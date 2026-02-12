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
