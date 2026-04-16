# Functions

`.zbashrc` に定義されている関数の一覧です。今回追加した `rgf` はこの一覧から除外しています。

## Utility

- `tmuxBackgroundToggle`: 現在の tmux pane の背景色をトグルする
- `ccc`: `.DS*`, `*.swp`, `Thumbs.db` を一括削除する
- `up [n]`: 親ディレクトリへ `n` 階層移動する

## Node / npm

- `load_npm`: `nvm` を読み込み、LTS の Node.js を有効化する
- `npm`: 初回呼び出し時に `load_npm` を実行してから `npm` を引き継ぐ
- `npx`: 初回呼び出し時に `load_npm` を実行してから `npx` を引き継ぐ
- `node_vi [args...]`: Node 環境を読み込んだ上で `nvim` を起動する

## SCSS

- `scss1compile <file.scss>`: 単一の `scss` ファイルを圧縮 CSS にコンパイルする
- `scss1watch <file.scss>`: 単一の `scss` ファイルを watch して CSS を更新する
- `scsswwatch <input> <output>`: 入出力パスを指定して `scss --watch` を実行する

## Search / selector

- `agg [pattern]`: `ag -l -u --depth -1` でファイル一覧検索する
- `_git_branch_candidates`: `fzf` 用の Git ブランチ候補一覧を返す内部関数
- `_fzf_popup`: 共通の `fzf` 表示設定を提供する内部関数
- `cdf`: ファイルを `fzf` で選んで `vim` で開く
- `cdd`: `node_modules` を除外したディレクトリを `fzf` で選んで移動する
- `cddf`: 全ディレクトリを `fzf` で選んで移動する
- `cdff`: 全ファイルを `fzf` で選んで `vim` で開く
- `switch_aws_profile`: `~/.aws/credentials` から AWS プロファイルを選んで切り替える
- `switch_venv`: `~/.venv` から Python 仮想環境を選んで有効化する

## Git / GitHub

- `gitpush_current_branch`: 現在のブランチを `git push -u origin` する
- `gitdiff_select_commit`: `fzf` で選んだコミットとの差分を表示する
- `gitshow_select_commit [path...]`: `fzf` で選んだコミットの `git show` を表示する
- `gitbase`: `git show-branch` ベースで比較元ブランチを推定する
- `gitdiff [path...]`: `fzf` で比較先ブランチを選んで `git diff` を表示する
- `ghswitch`: `gh` の認証ユーザを `fzf` で選んで切り替える

## Editor

- `nvim_swap_clean`: Neovim の swap ファイルを削除する
