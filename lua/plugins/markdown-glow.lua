return {
  "ellisonleao/glow.nvim",
  config = true,
  cmd = "Glow",
  -- ft = "markdown", -- 如果你希望打开md文件时自动触发，可以取消注释
  -- keys = {
  --   { "<leader>", "<cmd>Glow<cr>", desc = "Toggle Markdown Preview", ft = "markdown" },
  -- },
  -- 可选的自定义配置
  opts = {
    style = "dark", -- 或 "light"
    width = 120,
  },
}
