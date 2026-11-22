# 05. PC環境セットアップ手順（初心者向け）

> 対象：Windows 10/11。上から順番に行ってください。分からない画面があれば、スクリーンショットや表示された文字を Claude に送ってください。

## 手順1：Git と Git LFS をインストール

1. https://git-scm.com/download/win から「Git for Windows」をダウンロードしてインストール（設定はすべて初期値でOK。Git LFS も同梱されています）
2. PowerShell を開いて確認：
   ```powershell
   git --version
   git lfs install
   ```
   `Git LFS initialized.` と表示されれば成功です。
3. 名前とメールアドレスを登録（GitHubに登録したもの）：
   ```powershell
   git config --global user.name "あなたの名前"
   git config --global user.email "GitHubのメールアドレス"
   ```

## 手順2：作業フォルダを作る

日本語や空白を含まない短いパスにしてください（UEのビルドエラーを防ぐため）。

```powershell
mkdir C:\Dev
cd C:\Dev
```

## 手順3：このリポジトリをPCに取得

```powershell
git clone -b claude/online-survival-rpg-spec-i3n4hb https://github.com/7zkv7bps5y-cell/game.git
cd C:\Dev\game
```

ログインを求められたら GitHub アカウントでサインインします。

この時点で `tools/check-pc.ps1` を実行してPCスペックを確認できます（`01-environment.md` 参照）：

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\check-pc.ps1
```

## 手順4：Visual Studio 2022 Community をインストール

1. https://visualstudio.microsoft.com/ja/vs/community/ からダウンロード
2. インストーラーで **「C++によるゲーム開発」** にチェック
3. 右側の詳細で以下にもチェック：
   - 「Unreal Engine 用 IDE サポート」（Unreal Engine installer は不要）
   - 最新の Windows 11 SDK（または Windows 10 SDK）
4. インストール（数十GBあります）

## 手順5：Unreal Engine 5 をインストール

1. https://www.unrealengine.com/ から Epic Games Launcher をダウンロードしてインストール
2. Launcher の「Unreal Engine」→「ライブラリ」→「＋」で**最新の安定版 5.x** を追加してインストール
3. インストールしたバージョン番号をメモして Claude に伝えてください（以後このバージョンに固定します）

## 手順6：UEプロジェクトを作成（マイルストーン M1）

1. Unreal Engine を起動
2. 「ゲーム」→ **「Third Person（サードパーソン）」** を選択
3. 右側の設定：
   - プロジェクトの種類：**C++**
   - ターゲットプラットフォーム：デスクトップ
   - スターターコンテンツ：なし
4. 保存場所：`C:\Dev\game`
5. プロジェクト名：`SurvivalRPG`（**後から変更しにくい**ので、別名にしたい場合は作成前に決めてください。半角英字のみ）
6. 「作成」→ Visual Studio とエディタが開くまで待つ（初回は時間がかかります）

結果として `C:\Dev\game\SurvivalRPG\SurvivalRPG.uproject` ができます。

## 手順7：動作確認

1. エディタ上部の ▶（プレイ）ボタンを押し、キャラクターが動けば成功
2. ▶ の横の「︙」→「Number of Players」を **2**、「Net Mode」を **Play As Client** にしてプレイ
   → 2つのウィンドウで互いのキャラクターが見えればマルチプレイの基本動作OK（M3の事前確認）

## 手順8：Git にコミットして GitHub へ送る

エディタを閉じてから PowerShell で：

```powershell
cd C:\Dev\game
git status
```

`Binaries`、`Intermediate`、`Saved` などが表示されていないことを確認（`.gitignore` で除外済み）。問題なければ：

```powershell
git add .
git commit -m "M1: UE5 C++ プロジェクトを作成"
git push
```

push が終わったら Claude に知らせてください。M2（カメラ切り替え）以降のコードを追加します。

## 困ったとき
- エラーが出たら、**表示された文字を全部コピーして** Claude に貼り付けてください。
- ビルドのエラーは `C:\Dev\game\SurvivalRPG\Saved\Logs\` 内の最新 `.log` ファイルにも記録されます。
