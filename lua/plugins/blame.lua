-- https://github.com/FabijanZulj/blame.nvim
-- 逐行查看文件的 Git 归属与历史。
--
-- 使用方法：
--   <leader>gb  打开或关闭 Blame 窗口（Git Blame）
--
-- Blame 窗口内：
--   i       查看当前提交信息
--   <CR>    查看当前提交的完整内容与差异
--   <Tab>   查看当前提交之前的文件状态
--   <BS>    返回后一层文件状态
--   y       复制当前提交哈希
--   o       在浏览器中打开当前提交
--   q/<Esc> 关闭 Blame 窗口
return {
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function(_, opts)
      require("blame").setup(opts)
      vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle<CR>", { desc = "切换逐行 Git 追溯" })
    end,
    opts = {
      blame_options = { "-w" },
    },
  },
}
