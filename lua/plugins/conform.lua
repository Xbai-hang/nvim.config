-- https://github.com/stevearc/conform.nvim
-- 格式化，支持 LSP 和非 LSP，支持保存时自动格式化
return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        lua = { "stylua" }, -- lua 使用 stylua 格式化
        python = { "isort", "black" },
      },
    })
  end,
}
