# PC environment check for Unreal Engine 5 development.
# Usage (from the repository folder):
#   powershell -ExecutionPolicy Bypass -File .\tools\check-pc.ps1
# Writes pc-report.txt next to where you run it. Read-only: changes nothing on the PC.
# Output is ASCII on purpose (Windows PowerShell 5.1 encoding safety).

$ErrorActionPreference = 'Continue'
$lines = New-Object System.Collections.Generic.List[string]
function Add($text) { $lines.Add($text); Write-Host $text }

Add "=== PC report for UE5 development ==="
Add ("Date: " + (Get-Date -Format 'yyyy-MM-dd HH:mm'))

# OS
try {
    $os = Get-CimInstance Win32_OperatingSystem
    Add ("OS: " + $os.Caption + " (build " + $os.BuildNumber + ", " + $os.OSArchitecture + ")")
    Add ("RAM total: {0:N1} GB" -f ($os.TotalVisibleMemorySize / 1MB))
} catch { Add "OS: could not read" }

# CPU
try {
    foreach ($cpu in Get-CimInstance Win32_Processor) {
        Add ("CPU: " + $cpu.Name.Trim() + " | cores " + $cpu.NumberOfCores + " | threads " + $cpu.NumberOfLogicalProcessors)
    }
} catch { Add "CPU: could not read" }

# GPU (AdapterRAM is capped at 4 GB by Windows; use dxdiag for exact VRAM)
try {
    foreach ($gpu in Get-CimInstance Win32_VideoController) {
        Add ("GPU: " + $gpu.Name + " | driver " + $gpu.DriverVersion + " | reported VRAM {0:N1} GB (may be capped at 4)" -f ($gpu.AdapterRAM / 1GB))
    }
} catch { Add "GPU: could not read" }

# Disks
try {
    foreach ($d in Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3") {
        Add ("Disk " + $d.DeviceID + " free {0:N0} GB / total {1:N0} GB" -f ($d.FreeSpace / 1GB), ($d.Size / 1GB))
    }
    foreach ($p in Get-PhysicalDisk -ErrorAction SilentlyContinue) {
        Add ("Physical disk: " + $p.FriendlyName + " | " + $p.MediaType + " | " + $p.BusType)
    }
} catch { Add "Disk: could not read" }

# Tools
function Check-Command($name, $argsList) {
    $cmd = Get-Command $name -ErrorAction SilentlyContinue
    if ($cmd) {
        try { $v = (& $name @argsList 2>&1 | Select-Object -First 1); Add ("$name : " + $v) }
        catch { Add ("$name : found") }
    } else { Add ("$name : NOT FOUND") }
}
Check-Command "git" @("--version")
Check-Command "git-lfs" @("--version")

# Visual Studio
$vswhere = Join-Path ${env:ProgramFiles(x86)} "Microsoft Visual Studio\Installer\vswhere.exe"
if (Test-Path $vswhere) {
    $vs = & $vswhere -all -format value -property displayName
    if ($vs) { foreach ($v in $vs) { Add ("Visual Studio: " + $v) } } else { Add "Visual Studio: NOT FOUND" }
    $cpp = & $vswhere -all -requires Microsoft.VisualStudio.Workload.NativeGame -format value -property displayName
    if ($cpp) { Add "VS workload 'Game development with C++': installed" } else { Add "VS workload 'Game development with C++': NOT FOUND" }
} else { Add "Visual Studio: NOT FOUND (vswhere missing)" }

# Unreal Engine (launcher installs)
$ueRoots = @("$env:ProgramFiles\Epic Games", "D:\Epic Games", "E:\Epic Games")
$foundUE = $false
foreach ($root in $ueRoots) {
    if (Test-Path $root) {
        foreach ($dir in Get-ChildItem $root -Directory -Filter "UE_*" -ErrorAction SilentlyContinue) {
            Add ("Unreal Engine: " + $dir.Name + " at " + $dir.FullName); $foundUE = $true
        }
    }
}
if (-not $foundUE) { Add "Unreal Engine: not found in default locations (OK if not installed yet)" }

$out = Join-Path (Get-Location) "pc-report.txt"
$lines | Out-File -FilePath $out -Encoding ascii
Write-Host ""
Write-Host "Saved: $out"
Write-Host "Please paste the contents of pc-report.txt to Claude."
