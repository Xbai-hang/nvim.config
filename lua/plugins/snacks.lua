-- https://github.com/folke/snacks.nvim
-- 提供启动页、通知、LSP 单词引用高亮、Lazygit、终端和图片预览。
--
-- 操作：
--   <leader>nh  查看通知历史
--   <leader>gg  打开 Git 工作台（Lazygit）
--   <C-\>       切换浮动终端
--   <leader>otf 切换浮动终端
--   <leader>otb 切换底部终端
--   <leader>otr 切换右侧终端
--   <C-n>       从终端进入 Normal 模式，随后可按 q 隐藏终端
--   <leader>ip  预览光标下的图片
--
-- 数字前缀可打开同一布局下的多个终端，例如 2<leader>otb。
--
-- 外部依赖：
--   Lazygit 需要 lazygit。
--   图片预览需要支持 Kitty Graphics Protocol 的终端；非 PNG 图片需要 magick，Mermaid 需要 mmdc。
--   使用 :checkhealth snacks 检查环境；终端检测失败时可设置 SNACKS_<终端名>=true。
local terminal_layouts = {
  float = {
    position = "float",
    border = "rounded",
    width = 0.85,
    height = 0.85,
  },
  bottom = {
    position = "bottom",
    height = 0.35,
    stack = true,
  },
  right = {
    position = "right",
    width = 0.4,
    stack = true,
  },
}

local terminal_winbar = " %{get(b:, 'term_title', 'Terminal')} %=%{mode() ==# 't' ? 'TERMINAL' : 'NORMAL'} "

local function toggle_terminal(layout)
  local count = vim.v.count > 0 and vim.v.count or 1

  require("snacks").terminal.toggle(nil, {
    cwd = vim.fn.getcwd(0),
    count = count,
    -- Snacks 使用 cmd、cwd、env 和 count 标识终端；加入布局可避免不同方向复用同一实例。
    env = { NVIM_SNACKS_TERMINAL_LAYOUT = layout },
    win = terminal_layouts[layout],
  })
end

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
    lazygit = {
      -- 根据当前 Neovim 配色生成 Lazygit 主题，并启用返回 Neovim 编辑文件的集成。
      configure = true,
    },
    terminal = {
      win = {
        wo = {
          -- 浮动窗口没有独立状态栏，使用 Winbar 显示终端标题和当前模式。
          winbar = terminal_winbar,
        },
        keys = {
          -- 替换 Snacks 默认的双击 Esc 快捷键。
          term_normal = {
            "<C-n>",
            function()
              vim.cmd.stopinsert()
            end,
            mode = "t",
            expr = false,
            desc = "进入终端 Normal 模式",
          },
        },
      },
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
    {
      "<leader>gg",
      function()
        require("snacks").lazygit({ cwd = vim.fn.getcwd(0) })
      end,
      desc = "打开 Git 工作台（Lazygit）",
    },
    {
      "<leader>otf",
      function()
        toggle_terminal("float")
      end,
      desc = "切换项目浮动终端",
    },
    {
      [[<C-\>]],
      function()
        toggle_terminal("float")
      end,
      mode = { "n", "i", "t" },
      desc = "快速切换项目浮动终端",
    },
    {
      "<leader>otb",
      function()
        toggle_terminal("bottom")
      end,
      desc = "切换项目底部终端",
    },
    {
      "<leader>otr",
      function()
        toggle_terminal("right")
      end,
      desc = "切换项目右侧终端",
    },
  },
}
