-- https://github.com/folke/which-key.nvim
-- 显示当前可用的快捷键及其功能分组。
--
-- 操作：
--   <leader>? 查看当前 Buffer 可用的快捷键
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>b", group = "Buffer 操作" },
      { "<leader>f", group = "查找与格式化" },
      { "<leader>fc", group = "查找注释标记" },
      { "<leader>fz", group = "模糊查找（FzfLua）" },
      { "<leader>g", group = "Git 操作" },
      { "<leader>gh", group = "Git 变更块（Hunk）" },
      { "<leader>l", group = "LSP 操作" },
      { "<leader>n", group = "通知（Notifications）" },
      { "<leader>ot", group = "终端（Terminal）" },
      { "<leader>u", group = "功能开关" },
      { "<leader>w", group = "窗口操作（Window）" },
      { "z", group = "代码折叠" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "查看当前 Buffer 快捷键",
    },
  },
}
