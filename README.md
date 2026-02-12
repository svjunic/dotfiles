dotfiles
========

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

## Structure (excluding vim/neovim)

- `install/mac.sh`: mac 用の symlink セットアップ
- `install/linux-ssh.sh`: linux(ssh) 用の symlink セットアップ
- `shell/common.sh`: 共通 alias
- `shell/mac.sh`: mac 専用 alias/挙動
- `shell/linux-ssh.sh`: linux(ssh) 専用 alias

## Vim / Neovim install scripts

- `scripts/install_deps.sh`: 関連ライブラリ・依存のインストール
- `scripts/setup_*.sh`: 本体セットアップ（エディタ本体/設定反映）

- Vim
- `/Users/jun.fujimura/virtual/github/dotfiles/vim/scripts/install_deps.sh`
- `/Users/jun.fujimura/virtual/github/dotfiles/vim/scripts/setup_mac.sh`
- `/Users/jun.fujimura/virtual/github/dotfiles/vim/scripts/setup_linux.sh`

- Neovim
- `/Users/jun.fujimura/virtual/github/dotfiles/neovim/scripts/install_deps.sh`
- `/Users/jun.fujimura/virtual/github/dotfiles/neovim/scripts/setup_mac.sh`
