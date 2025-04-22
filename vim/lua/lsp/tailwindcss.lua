require("lspconfig").tailwindcss.setup{
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- 追加のクラス名検出ルールを設定可能
          { "tw`([^`]*)", "tw=\"([^\"]*)", "tw={\"([^\"]*)", "tw\\.\\w+`([^`]*)" }
        }
      }
    }
  }
}
