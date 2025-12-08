-- https://github.com/ibhagwan/fzf-lua
-- 文件模糊搜索
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup()
    vim.keymap.set("n", "<leader>fzf", require("fzf-lua").files, { desc = "Search over files" })
    vim.keymap.set("n", "<leader>fzg", require("fzf-lua").git_files, { desc = "Search over git files" })
    vim.keymap.set("n", "<leader>fzc", require("fzf-lua").live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fzr", require("fzf-lua").resume, { desc = "Resume fzf-lua" })
  end,
}
