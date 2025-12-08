-- https://github.com/nvim-tree/nvim-tree.lua
-- nvim-tree 文件树，依赖终端字体：Hack Nerd Font https://www.nerdfonts.com/font-downloads
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- 禁用默认启动
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup()

    -- 快捷键
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
  end,
}
