-- https://github.com/FabijanZulj/blame.nvim
-- 查看文件修改历史
return {
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require("blame").setup({})
      vim.keymap.set("n", "gb", "<cmd>BlameToggle<CR>", { desc = "Git BlameToggle" })
    end,
    opts = {
      blame_options = { "-w" },
    },
  },
}
