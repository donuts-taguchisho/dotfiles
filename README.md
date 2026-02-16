#GitHub にプッシュする [README.md](http://README.md) の下書き。構成案をもとに肉付けしていく。

<aside>
✏️

このページの内容を Markdown としてコピーし、`README.md` に貼り付ける想定。

</aside>

---

# dotfiles

macOS（Apple Silicon）向けの個人 dotfiles。

エディタ・ターミナル・シェルの設定ファイルと、開発用ユーティリティスクリプトを管理しています。

**このREADMEを上から順に実行すれば、新しい端末の初期設定が完了します。**

---

## Contents

```
~/dotfiles/
├── .zshrc                        # Zsh 設定
├── .config/
│   ├── doom/                     # Doom Emacs 設定
│   │   ├── init.el
│   │   ├── config.el
│   │   ├── packages.el
│   │   └── custom.el
│   ├── nvim/                     # Neovim (LazyVim) 設定
│   ├── nvim.bak/                 # 旧 Neovim 設定（バックアップ）
│   └── wezterm/                  # WezTerm ターミナル設定
│       ├── wezterm.lua
│       └── keybinds.lua
├── bin/
│   ├── install-doom-emacs.sh     # Doom Emacs 自動インストーラー
│   ├── uninstall-doom-emacs.sh   # Doom Emacs アンインストール
│   ├── dev-build.sh              # Raycast: gcloud ビルド
│   ├── dev-deploy.sh             # Raycast: gcloud デプロイ
│   ├── rspec.sh                  # Raycast: Docker 経由 RSpec
│   └── list_mac_apps.sh          # インストール済みアプリ一覧
├── .gitignore
└── README.md
```

---

## Requirements

- **OS**: macOS（Apple Silicon / `/opt/homebrew`）
- **Homebrew**: パッケージマネージャ

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

---

## Additional Tools

このリポジトリに含まれていないが、開発環境として必要なツール群。

### ターミナルマルチプレクサ

```bash
brew install zellij
```

- [Zellij](https://github.com/zellij-org/zellij)

### CLI ユーティリティ

```bash
# TODO: 各ツールのインストールコマンドを確定させる
```

- [keifu](https://github.com/trasta298/keifu) — 系譜ツリー表示
- [filetree](https://github.com/nyanko3141592/filetree) — ディレクトリ可視化（[yazi](https://github.com/sxyazi/yazi) への乗り換え検討中）

### フォント

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

### エディタ関連

```bash
# Neovim の IME 自動 OFF 用
brew tap daipeihust/tap && brew install im-select
```

- [Raycast](https://www.raycast.com/) — bin/ スクリプトの実行基盤（App Store or 公式サイトからインストール）

### 言語ランタイム

```bash
# Ruby（rbenv or mise）
brew install rbenv
rbenv install <version>

# Node.js（nvm）
brew install nvm
nvm install --lts

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### 仕事用

```bash
brew install mysql@8.0
# Google Cloud SDK — https://cloud.google.com/sdk/docs/install
# Docker Desktop — https://www.docker.com/products/docker-desktop/
```

---

## Installation

### 1. Clone

```bash
git clone https://github.com/oboro-yudachi/dotfiles.git ~/dotfiles
```

### 2. Symlinks

```bash
# .zshrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc

# .config 配下（アプリ単位）
mkdir -p ~/.config
for app in doom nvim wezterm; do
  ln -sf ~/dotfiles/.config/$app ~/.config/$app
done
```

### 3. Raycast Script Commands

Raycast の **Extensions > Script Commands > Add Directories** で `~/dotfiles/bin` を追加する。

または個別に symlink:

```bash
# Raycast のスクリプトディレクトリに symlink
for script in dev-build.sh dev-deploy.sh rspec.sh; do
  ln -sf ~/dotfiles/bin/$script <Raycast Script Commands ディレクトリ>/
done
```

### 4. Doom Emacs

```bash
chmod +x ~/dotfiles/bin/install-doom-emacs.sh
~/dotfiles/bin/install-doom-emacs.sh
```

---

## Configuration Details

### Zsh（`.zshrc`）

<!-- TODO: PATH に追加しているもの一覧と説明 -->

- rbenv / mise — Ruby バージョン管理
- nvm — Node.js バージョン管理
- Cargo — Rust ツールチェーン
- Google Cloud SDK — gcloud CLI（パス・補完）
- openssl@3 — 暗号ライブラリ
- mysql@8.0 — MySQL クライアント
- Doom Emacs — `~/.local/bin` 等
- Homebrew — `/opt/homebrew`

各パスは条件分岐（`if [ -d ... ]` / `if [ -f ... ]`）で、ツールが存在するときだけ読み込む設計。

### WezTerm（`.config/wezterm/`）

- **フォント**: JetBrains Mono + Nerd Font Symbols（12pt）
- **外観**: 透過背景（opacity 0.85）、背景ぼかし、タブバー非表示
- **Leader key**: `Ctrl+Space`（timeout 10s）
- **キーバインド**: `keybinds.lua` で定義。ペイン操作、タブ移動、スクロール等
- デフォルトキーバインドは無効化し、すべてカスタム定義

### Doom Emacs（`.config/doom/`）

<!-- TODO: init.el から有効モジュールを抜粋 -->

**主な有効モジュール:**

- Ruby / Rails（+lsp）
- org-mode（+present）
- web-mode / JavaScript（+lsp）
- JSON / YAML
- tree-sitter
- LSP（+peek）

**追加パッケージ（packages.el）:**

- org-modern, org-appear, org-tree-slide
- vdiff-magit, magit-delta
- rails-routes, rails-i18n, erblint
- consult-lsp

設定変更後は `doom sync` を実行すること。

### Neovim / LazyVim（`.config/nvim/`）

- **カラースキーム**: gruvbox
- **クリップボード**: システムクリップボードと共有（`unnamedplus`）
- **キーマップ**:
    - `d` / `c` / `s` → ブラックホールレジスタ（削除でヤンクを上書きしない）
    - `x` → `d` に置換（cut 操作として使用）
- **IME 自動 OFF**: `im-select` を使用。Insert / Cmdline モード離脱時に自動で英字入力に切替

---

## Scripts（`bin/`）

| スクリプト | 用途 | 引数 |
| --- | --- | --- |
| `install-doom-emacs.sh` | Doom Emacs の一括インストール | なし |
| `uninstall-doom-emacs.sh` | Doom Emacs の完全アンインストール | なし |
| `dev-build.sh` | gcloud ステージングビルド（Raycast） | `$1`: タグ, `$2`: ブランチ |
| `dev-deploy.sh` | gcloud ステージングデプロイ（Raycast） | `$1`: タグ, `$2`: バージョン名, `$3`: ブランチ |
| `rspec.sh` | Docker 経由で RSpec 実行（Raycast） | `$1`: ファイル名 |
| `list_mac_apps.sh` | インストール済み Mac アプリ一覧 | なし |

Raycast スクリプト（`@raycast.*` メタデータ付き）は、Raycast の **Script Commands > Add Directories** で `~/dotfiles/bin` を登録すると使用可能。

---

## Company Fork

<!-- TODO: 必要に応じて remotes 設計を記載 -->

```bash
# 個人リポジトリを origin、会社 fork を company として管理
git remote add company <会社 fork の URL>
```

---

## TODO

- [ ]  `bin/bootstrap.sh` — clone → symlink → brew install → ランタイム → doom install をワンコマンド化
- [ ]  `Brewfile` でパッケージ宣言管理（`brew bundle dump` → `brew bundle`）
- [ ]  macOS システム設定（`defaults write` 系）
- [ ]  Zellij 等の `.config/` 配下設定ファイルをリポジトリに追加
- [ ]  keifu / filetree のインストールコマンド確定 dotfiles
