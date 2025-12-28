local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

configs.setup {
  ensure_installed = {
    -- Web / Frontend
    "html",
    "css",
    "scss",
    "javascript",
    "typescript",
    "json",

    -- Markdown / ドキュメント
    "markdown",
    "markdown_inline",
    "yaml",  -- 例: Frontmatter 用や設定ファイル用

    -- Next.js / Node.js 関連
    "lua",        -- Neovim 設定用
    "bash",       -- シェルスクリプト
    "toml",       -- Rust や toolchain 設定に
    "vim",        -- Vimscript 部分もまだ残るなら
    "regex",      -- 正規表現のハイライト
    "tsx",        -- React (TypeScript + JSX)

    -- Git / DevOps
    "gitcommit",
    "git_rebase",
    "gitattributes",
    "gitignore"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = false },
  auto_install = true,
}

-- うまく attach されない環境向けのフォールバック。
-- 本来は nvim-treesitter が FileType autocmd で自動 attach しますが、
-- ロード順やクエリ/パーサ状態の影響で外れる場合があるので、
-- 対象 ft の BufEnter で一度だけ start を試します。
local function ensure_ts_started(bufnr)
  if vim.treesitter.highlighter and vim.treesitter.highlighter.active and vim.treesitter.highlighter.active[bufnr] then
    return
  end

  local ok_parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok_parser then
    return
  end

  pcall(vim.treesitter.start, bufnr)
end

local ts_fallback_group = vim.api.nvim_create_augroup('MyTSStartLua', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = ts_fallback_group,
  pattern = { '*.js', '*.mjs', '*.cjs', '*.jsx', '*.ts', '*.tsx', '*.lua', '*.vim' },
  callback = function(args)
    ensure_ts_started(args.buf)
  end,
})
