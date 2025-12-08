-- https://github.com/nmac427/guess-indent.nvim
-- 自动缩进，根据当前缩进猜测缩进配置，免去为每种语言配置缩进的麻烦
return {
  "nmac427/guess-indent.nvim",
  priority = 1000, -- 确保优先加载
  config = function()
    require("guess-indent").setup({})
  end,
}
