local ok, neotest = pcall(require, "neotest")
if not ok then
  return
end

local function first_existing(paths)
  for _, path in ipairs(paths) do
    if vim.loop.fs_stat(path) then
      return path
    end
  end
  return paths[1]
end

local cwd = vim.loop.cwd()

neotest.setup({
  adapters = {
    require("neotest-playwright").adapter({
      options = {
        persist_project_selection = true,
        enable_dynamic_test_discovery = true,

        get_playwright_binary = function()
          return cwd .. "/node_modules/.bin/playwright"
        end,

        get_playwright_config = function()
          return first_existing({
            cwd .. "/playwright.config.ts",
            cwd .. "/playwright.config.js",
            cwd .. "/playwright.config.mjs",
            cwd .. "/playwright.config.cjs",
          })
        end,

        get_cwd = function()
          return cwd
        end,

        filter_dir = function(name)
          return name ~= "node_modules"
        end,
      },
    }),
  },
})

-- キーマップ（`,pp*`）
local map = vim.keymap.set

map("n", ",pp", "[playwright]", { remap = true })

map("n", "[playwright]n", function()
  neotest.run.run()
end, { desc = "Test nearest" })

map("n", "[playwright]f", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Test file" })

map("n", "[playwright]s", function()
  neotest.run.run({ suite = true })
end, { desc = "Test suite" })

map("n", "[playwright]l", function()
  neotest.run.run_last()
end, { desc = "Test last" })

map("n", "[playwright]x", function()
  neotest.run.stop()
end, { desc = "Test stop" })

map("n", "[playwright]a", function()
  neotest.run.attach()
end, { desc = "Test attach" })

map("n", "[playwright]o", function()
  neotest.output.open({ enter = true, auto_close = true })
end, { desc = "Test output" })

map("n", "[playwright]t", function()
  neotest.summary.toggle()
end, { desc = "Test summary" })

map("n", "[playwright][", function()
  neotest.jump.prev({ status = "failed" })
end, { desc = "Prev failed test" })

map("n", "[playwright]]", function()
  neotest.jump.next({ status = "failed" })
end, { desc = "Next failed test" })
