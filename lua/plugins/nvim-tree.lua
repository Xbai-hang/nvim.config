-- https://github.com/nvim-tree/nvim-tree.lua
-- 常驻侧边栏文件树；跟随当前窗口工作目录，不主动改变项目根目录。
--
-- 外部依赖：
--   Nerd Font  显示文件类型图标
--   trash      将文件移入系统回收站；缺失时 d 操作不可用
--
-- 全局操作：
--   <leader>e  打开或关闭文件树
--
-- 文件树内常用操作：
--   <CR>/o     打开文件或目录
--   <Tab>      预览文件
--   <C-v>      在垂直分屏打开
--   <C-x>      在水平分屏打开
--   a          新建文件或目录（以 / 结尾表示目录）
--   r          重命名
--   d          移入系统回收站
--   c/x/p      复制/剪切/粘贴
--   H/I        显示或隐藏点文件/Git 忽略文件
--   R          刷新文件树
--   q          关闭文件树
--   <leader>h  查看完整快捷键帮助（原生键位 g? 仍然可用）
local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  api.map.on_attach.default(bufnr)

  local function map(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
      desc = desc,
    })
  end

  -- 默认 d 会永久删除文件；改用系统回收站，降低误操作风险。
  map("d", api.fs.trash, "文件树：移入回收站")
  map("<leader>h", api.tree.toggle_help, "查看文件树快捷键")
end

return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    -- 官方建议在插件初始化前禁用 netrw，避免目录接管发生竞争。
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "切换文件树" },
  },
  opts = {
    on_attach = on_attach,
    -- 跟随当前窗口 cwd，并优先采用 Buffer 已设置的工作目录。
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      -- 只在树内定位当前文件，不反向改写文件树根目录。
      update_root = false,
    },
    trash = {
      cmd = "trash",
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    local api = require("nvim-tree.api")
    local event = api.events.Event

    -- TreeOpen/TreeClose 常与 Resize 连续触发；合并到同一轮调度，避免
    -- Dashboard 先按旧视口重绘一帧，再回到左上角。
    local refresh_pending = false

    local function reset_dashboard_view()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "snacks_dashboard" then
          vim.api.nvim_win_call(win, function()
            vim.fn.winrestview({ leftcol = 0, topline = 1 })
          end)
        end
      end
    end

    -- 文件树改变窗口布局后，重新计算 Dashboard，并清除 Neovim 为保持
    -- 旧光标可见而留下的水平/垂直视口偏移。
    local function refresh_dashboard()
      if refresh_pending then
        return
      end
      refresh_pending = true
      vim.schedule(function()
        refresh_pending = false
        reset_dashboard_view()
        require("snacks").dashboard.update()
      end)
    end

    api.events.subscribe(event.TreeOpen, refresh_dashboard)
    api.events.subscribe(event.TreeClose, refresh_dashboard)
    api.events.subscribe(event.Resize, refresh_dashboard)
  end,
}
