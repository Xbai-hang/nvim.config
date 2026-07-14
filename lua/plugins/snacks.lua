-- https://github.com/folke/snacks.nvim
-- 提供启动页、通知历史、LSP 单词引用高亮和终端图片预览。
--
-- 操作：
--   <leader>nh  查看通知历史
--   <leader>ip  预览光标下的图片引用
--
-- Image：
--   支持直接打开图片文件，以及在 Markdown 等文档中内联显示图片。
--
-- Image 依赖：
--   必需：支持 Kitty Graphics Protocol 的终端，如 Ghostty、Kitty 或 WezTerm。
--   PNG：无需额外转换工具。
--   其他图片格式：需要 ImageMagick 提供 magick 命令。
--   Mermaid：需要 @mermaid-js/mermaid-cli 提供 mmdc 命令。
--   Typst：需要 typst 命令。
--   LaTeX/PDF：需要 pdflatex 与 Ghostscript（gs）；本配置暂不启用数学渲染。
--
-- macOS 安装示例：
--   brew install imagemagick typst ghostscript
--   npm install -g @mermaid-js/mermaid-cli
--
-- NOTE: 不同系统请使用对应包管理器安装同名工具，并通过 :checkhealth snacks 检查。
-- NOTE: 若终端自动检测失败，可设置 SNACKS_<终端名>=true，例如 SNACKS_GHOSTTY=true。
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "查找文件", action = ":FzfLua files" },
          { icon = " ", key = "g", desc = "全局搜索", action = ":FzfLua live_grep" },
          { icon = " ", key = "n", desc = "新建文件", action = ":ene | startinsert" },
          { icon = " ", key = "s", desc = "Git 状态", action = ":FzfLua git_status" },
          { icon = " ", key = "r", desc = "最近文件", action = ":FzfLua oldfiles" },
          { icon = " ", key = "q", desc = "退出 Neovim", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { title = "⚡ 快捷导航", padding = 1 },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          section = "recent_files",
          title = "🕒 最近打开的文件 (LRU)",
          padding = 1,
          limit = 8,
        },
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    words = {
      enabled = true,
    },
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
        float = true,
      },
      math = {
        enabled = false,
      },
    },
  },
  keys = {
    {
      "<leader>nh",
      function()
        require("snacks").notifier.show_history()
      end,
      desc = "通知历史",
    },
    {
      "<leader>ip",
      function()
        require("snacks").image.hover()
      end,
      desc = "预览光标下图片",
    },
  },
}
