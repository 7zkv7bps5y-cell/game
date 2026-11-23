# オンラインサバイバルRPG（仮称）

マルチプレイ主軸のオープンワールド型サバイバル・アクションRPG。Unreal Engine 5 で開発予定。

## 現在の状態

**計画段階**。ゲーム本体のコードやアセットはまだありません。

| 段階 | 状態 |
|---|---|
| 環境確認・構成提案・難易度評価 | ✅ 文書化済み（`docs/`） |
| PC環境の確認 | ⏳ ユーザーが `tools/check-pc.ps1` を実行して結果共有待ち |
| プロトタイプ P1（M1〜M8） | ⏳ 承認待ち |

## ドキュメント

| ファイル | 内容 |
|---|---|
| [docs/01-environment.md](docs/01-environment.md) | 開発環境の確認結果・推奨PCスペック・推奨ソフト |
| [docs/02-architecture.md](docs/02-architecture.md) | Unreal Engine での実現構成案（サーバー構成・採用技術・不正対策） |
| [docs/03-difficulty-and-sourcing.md](docs/03-difficulty-and-sourcing.md) | 実装難易度評価・自作/外部技術の分類・費用削減案 |
| [docs/04-prototype-plan.md](docs/04-prototype-plan.md) | 最初に作る技術検証プロトタイプ |
| [docs/05-setup-guide.md](docs/05-setup-guide.md) | PC環境セットアップ手順（コマンド付き） |
| [docs/06-materials-and-trade.md](docs/06-materials-and-trade.md) | 狩猟素材の獲得・劣化・流通・個人依頼の設計 |

## 開発ルール（抜粋）

- 既存ファイルを確認せずに上書きしない
- 動作確認できる単位で実装し、ビルド・テストを行う
- 「仮実装」と「完成機能」を明確に区別する
- 有料素材の購入は必ず事前承認を得る
- 仮アセットは `Content/_Placeholder/` に隔離する
