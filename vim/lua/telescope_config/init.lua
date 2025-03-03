require("telescope").setup{
  defaults = {
    borderchars = {
      "─",
      "│",
      "─",
      "│",
      "╭",
      "╮",
      "╯",
      "╰"
    },
    layout_config = {
      prompt_position = "bottom",  -- プロンプトを下に配置
      horizontal = {
        mirror = false,
        preview_width = 0.6,
      },
      vertical = {
        mirror = false,
      },
      width = 0.9,
      height = 0.9,
    },
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",  -- または必要に応じて "vertical"
    results_height = 0.5,  -- 必要に応じて高さを調整
    preview_cutoff = 120,  -- プレビューの制限
  },
}
