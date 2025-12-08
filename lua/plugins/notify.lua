-- https://github.com/rcarriga/nvim-notify
-- 优化 neovim 通知体验，改为右上角更美观显示
return {
  "rcarriga/nvim-notify",
  -- 使用高优先级，确保它能在其他插件之前/被其他插件加载时覆写 vim.notify
  priority = 1000,
  config = function()
    -- require("notify")("notify info message", "info", { title = "测试" })

    -- 替换 vim 默认的通知函数
    vim.notify = require("notify")
  end,
}
