# neovim

このディレクトリは Neovim (0.11.5+) 用の設定です。`vim/` 配下の設定をベースに **lazy.nvim** へ移行しています。

## 方針

- 変更範囲は `neovim/` 配下のみ
- プラグイン管理は `lazy.nvim`
- **ddu/denops は使用しない**（neovim 側へ移植しない）
- 検索は **telescope**、ファイル管理は **oil** に寄せる
- `,d` は未割り当て（再割当てしない）
- `live_grep` は hidden を検索する（`rg --hidden` 相当）
- `vim/auto.vim` の filetype 上書きは「コメントとして保管」し、neovim では有効化しない

## 導入（symlink運用）

例:

- `~/.config/nvim` → この `neovim/` を symlink

## 依存

- `rg` (ripgrep): telescope の `live_grep` に必要
- `make` / ビルドツール: `telescope-fzf-native.nvim` に必要
- 各種 LSP サーバ: `vtsls`, `vue-language-server`, `astro-language-server`, `marksman`, `yaml-language-server` など

## キーマップ

- 検索（telescope）
  - `,fff` / `,ffF`: find_files
  - `,ffg`: live_grep（hidden対応）
  - `,ffb`: buffers
  - `,ffr`: oldfiles
- ファイル操作（oil）
  - `-`: Oil

## ファイル構成

- `init.lua`: エントリポイント
- `lua/config/*`: options/keymaps/autocmds/lazy
- `lua/plugins/*`: 各プラグイン設定
