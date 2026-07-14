-- https://github.com/windwp/nvim-autopairs
-- 自动补全并维护括号、引号等成对字符。
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    -- 借助 Treesitter 判断语法上下文，减少字符串等位置的错误配对。
    check_ts = true,

    -- 在插件输入框和特殊 Buffer 中禁用自动配对。
    disable_filetype = {
      "TelescopePrompt",
      "spectre_panel",
      "snacks_picker_input",
    },

    -- 同一行已经存在右括号时，不再重复生成。
    enable_check_bracket_line = true,

    -- 回车时展开括号，退格时成对删除。
    map_cr = true,
    map_bs = true,
  },
}
