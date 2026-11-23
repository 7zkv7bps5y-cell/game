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

### ゲームデザイン資料（総合版）

**まず [docs/00-game-design-master.md](docs/00-game-design-master.md) を読んでください。** 全体の要約と、各資料の地図になっています。

| ファイル | 内容 |
|---|---|
| [docs/00-game-design-master.md](docs/00-game-design-master.md) | 総合設計書（全体像・状態ラベル付き） |
| [docs/01-world-and-story.md](docs/01-world-and-story.md) | 世界観・ストーリー・マップ・派閥 |
| [docs/02-game-systems.md](docs/02-game-systems.md) | ゲームシステム |
| [docs/03-economy-and-trading.md](docs/03-economy-and-trading.md) | 経済・流通 |
| [docs/05-open-questions.md](docs/05-open-questions.md) | 未決定事項・矛盾一覧 |
| [docs/06-system-dependencies.md](docs/06-system-dependencies.md) | システム依存関係 |

### 技術・計画資料

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
