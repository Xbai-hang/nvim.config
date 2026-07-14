-- https://github.com/lukas-reineke/indent-blankline.nvim
-- 显示缩进层级，并突出当前代码作用域。
return {
  "lukas-reineke/indent-blankline.nvim",
  -- v3 起插件入口由 indent_blankline 更名为 ibl。
  main = "ibl",
  event = "VeryLazy",
  opts = {
    -- 普通缩进使用较轻的虚线，减少对代码内容的干扰。
    indent = { char = "┊" },
    scope = {
      -- 当前作用域使用实线，与普通缩进形成层级区分。
      char = "│",
      -- 绘制作用域首尾横线，帮助识别当前代码块边界。
      show_start = true,
      show_end = true,
    },
  },
  keys = {
    {
      "<leader>ui",
      -- 使用插件原生命令真正启用或停用渲染。
      "<cmd>IBLToggle<cr>",
      desc = "切换缩进参考线",
    },
  },
}
