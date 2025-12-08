-- https://github.com/akinsho/toggleterm.nvim
-- 临时终端（浮动 toggle 终端 term）
return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      size = 12,
      open_mapping = [[<C-\>]], -- ✅ 快捷键语法正确
      hide_numbers = true, -- 隐藏终端左侧数字行
      start_in_insert = true,
      close_on_exit = true,
      shell = vim.o.shell, -- 使用系统配置的默认 shell
      direction = "float",
    })
  end,
}
