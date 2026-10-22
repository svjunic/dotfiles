# dotfiles

my dotfiles.

## Setup

### mac

```bash
./setup_dotfiles.zsh
```

### linux (ssh)

```bash
./setup_dotfiles.zsh
```

`Linux` の場合は `install/linux-ssh.sh` が使われます。

インストール中にメインで使うツール（Codex / Claude）を選択します。
選択した `worktrunk/config.codex.toml` または `worktrunk/config.claude.toml` を
`${XDG_CONFIG_HOME:-~/.config}/worktrunk/config.toml` にリンクします。
Codex はリポジトリの隣、Claude は `.claude/worktrees/` 配下にワークツリーを作成します。
既存の設定ファイルはバックアップされます。

## Structure (excluding vim/neovim)

- `install/mac.sh`: mac 用の symlink セットアップと基本コマンド導入
- `install/linux-ssh.sh`: linux(ssh) 用の symlink セットアップ
- `shell/common.sh`: 共通 alias
- `shell/mac.sh`: mac 専用 alias/挙動
- `shell/linux-ssh.sh`: linux(ssh) 専用 alias
- [functions.md](/Users/jun.fujimura/virtual/github/dotfiles/functions.md): `.zbashrc` の関数一覧

## Vim / Neovim install scripts

- `scripts/install_deps.sh`: 関連ライブラリ・依存のインストール
- `scripts/setup_*.sh`: 本体セットアップ（エディタ本体/設定反映）

- Vim
  - `~/virtual/github/dotfiles/vim/scripts/install_deps.sh`
  - `~/virtual/github/dotfiles/vim/scripts/setup_mac.sh`
  - `~/virtual/github/dotfiles/vim/scripts/setup_linux.sh`

- Neovim
  - `~/virtual/github/dotfiles/neovim/scripts/install_deps.sh`
  - `~/virtual/github/dotfiles/neovim/scripts/setup_mac.sh`
