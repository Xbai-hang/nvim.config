-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- 在 Neovim 内渲染仓库 README、用户文档、标准 Markdown 和少量内嵌 HTML。
-- 普通模式用于阅读，插入模式恢复 Markdown 源码；Mermaid 图表交给 Snacks.image 持续显示。
--
-- 操作：
--   :RenderMarkdown toggle  切换当前 Neovim 会话的 Markdown 渲染
--   :RenderMarkdown preview 在侧边窗口打开渲染预览
--   :RenderMarkdown config  查看当前配置与默认配置的差异
--   :checkhealth render-markdown 检查 parser 等依赖
--
-- 外部程序：
--   Mermaid：mmdc，由 Snacks.image 调用生成流程图
--
-- NOTE: 多格式、节点级混合编辑的替代品是 OXY2DEV/markview.nvim。
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown" },
  opts = {
    -- 阅读时渲染；进入插入模式后恢复源码，避免 Markdown 标记被隐藏而难以编辑。
    render_modes = { "n", "c", "t" },

    -- 光标行暂时撤销图标和虚拟文本，便于直接检查原始 Markdown 标记。
    anti_conceal = {
      enabled = true,
      above = 0,
      below = 0,
    },

    latex = {
      enabled = false,
    },

    -- Sign Column 专门留给 Git 与诊断状态。
    sign = {
      enabled = false,
    },

    heading = {
      sign = false,
      -- 使用同一图标族表达标题层级；一级、二级标题铺满窗口，其余标题保持紧凑。
      icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      position = "inline",
      width = { "full", "full", "block" },
      left_pad = 1,
      right_pad = 1,
    },

    code = {
      sign = false,
      style = "full",
      position = "left",
      -- 使用完整宽度；padding 保持为 0，避免含 Tab 的代码块被插件扩大到 tabstop 宽度。
      width = "full",
      left_pad = 0,
      right_pad = 0,
      -- 不隐藏整行围栏，避免 conceal_lines 阻断 Snacks.image 的 Mermaid 图片锚点。
      border = "none",
      -- 仅在代码块标题显示一次 Devicon 和语言名称；Sign Column 图标仍保持关闭。
      language_icon = true,
      language_name = true,
      language_info = true,
      language_pad = 0,
    },

    bullet = {
      -- 无序列表使用几何符号；有序列表由 ordered_icons 独立显示数字。
      icons = { "•", "◦", "▪", "▫" },
      ordered_icons = function(ctx)
        return ("%d."):format(ctx.index)
      end,
      right_pad = 1,
    },

    checkbox = {
      unchecked = { icon = "□ " },
      checked = { icon = "✓ " },
      custom = {
        todo = { raw = "[-]", rendered = "◐ ", highlight = "RenderMarkdownTodo" },
      },
    },

    quote = {
      icon = ">",
    },

    -- GitHub 标准 Callout 使用文字标签，避免依赖难以辨认的装饰图标。
    callout = {
      note = { raw = "[!NOTE]", rendered = "NOTE", highlight = "RenderMarkdownInfo", category = "github" },
      tip = { raw = "[!TIP]", rendered = "TIP", highlight = "RenderMarkdownSuccess", category = "github" },
      important = {
        raw = "[!IMPORTANT]",
        rendered = "IMPORTANT",
        highlight = "RenderMarkdownHint",
        category = "github",
      },
      warning = { raw = "[!WARNING]", rendered = "WARNING", highlight = "RenderMarkdownWarn", category = "github" },
      caution = { raw = "[!CAUTION]", rendered = "CAUTION", highlight = "RenderMarkdownError", category = "github" },
    },

    pipe_table = {
      preset = "round",
      cell = "padded",
    },

    html = {
      enabled = true,
      comment = {
        conceal = true,
      },
    },
  },
}
