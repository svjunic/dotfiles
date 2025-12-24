require('nvim-treesitter.configs').setup {
  -- ensure_installed = "all",
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
    "astro",      -- astro

    -- AI / Python 活用
    "python",

    -- Git / DevOps
    "gitcommit",
    "git_rebase",
    "gitattributes",
    "gitignore"
  },
  highlight = {
    enable = true
  },
  incremental_selection = { enable = false }
}

-- require('nvim-treesitter.configs').setup({
--   highlight = { enable = true },
-- })
