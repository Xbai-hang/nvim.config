-- https://github.com/akinsho/bufferline.nvim
-- 在顶部显示已打开的 Buffer。
--
-- 操作：
--   <C-h>/<C-l> 或 <leader>bh/<leader>bl 切换上一个/下一个 Buffer
--   <leader>bp   标记并选择一个可见 Buffer
--   <leader>bo   新建一个空白 Buffer
--   <leader>bc   安全关闭当前 Buffer
--   <leader>bC   安全关闭当前 Buffer 之外的其他 Buffer
--   <leader>bH/L 向左/右移动当前 Buffer 标签
--   左键点击      切换 Buffer
--   关闭按钮/右键 安全删除 Buffer
--
-- 仅存在真实文件 Buffer 时显示；启动页、文件树和终端不会单独触发 Bufferline。
local function delete_buffer(bufnr)
  require("snacks").bufdelete(bufnr)
end

local function theme_color(highlight, attribute)
  return { highlight = highlight, attribute = attribute }
end

local function has_file_buffer()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted and vim.bo[bufnr].buftype == "" then
      local name = vim.api.nvim_buf_get_name(bufnr)
      local lines = vim.api.nvim_buf_line_count(bufnr)
      local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""

      -- 排除 Neovim 启动时自动创建的空白 [No Name] Buffer。
      if name ~= "" or vim.bo[bufnr].modified or lines > 1 or first_line ~= "" then
        return true
      end
    end
  end

  return false
end

local function update_visibility()
  -- Bufferline 独占 showtabline：有真实文件时显示，否则隐藏。
  local showtabline = has_file_buffer() and 2 or 0
  if vim.o.showtabline ~= showtabline then
    vim.o.showtabline = showtabline
    vim.cmd.redrawtabline()
  end
end

return {
  "akinsho/bufferline.nvim",
  -- Bufferline 是常驻界面；启动时加载可避免首次按切换键后才显示。
  lazy = false,
  -- 跟随最新稳定 tag；lazy-lock.json 仍会锁定具体 commit。
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/snacks.nvim",
  },
  keys = {
    { "<C-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "切换到上一个 Buffer" },
    { "<C-l>", "<cmd>BufferLineCycleNext<CR>", desc = "切换到下一个 Buffer" },
    { "<leader>bh", "<cmd>BufferLineCyclePrev<CR>", desc = "切换到上一个 Buffer" },
    { "<leader>bl", "<cmd>BufferLineCycleNext<CR>", desc = "切换到下一个 Buffer" },
    { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "标记并选择 Buffer" },
    { "<leader>bo", "<cmd>enew<CR>", desc = "新建空白 Buffer" },
    { "<leader>bC", "<cmd>BufferLineCloseOthers<CR>", desc = "关闭当前 Buffer 之外的其他 Buffer" },
    { "<leader>bH", "<cmd>BufferLineMovePrev<CR>", desc = "向左移动当前 Buffer" },
    { "<leader>bL", "<cmd>BufferLineMoveNext<CR>", desc = "向右移动当前 Buffer" },
    {
      "<leader>bc",
      function()
        delete_buffer()
      end,
      desc = "安全关闭当前 Buffer",
    },
  },
  opts = {
    -- 使用主题自身的背景层次，避免 Bufferline 默认的近黑色与编辑区割裂。
    highlights = {
      fill = {
        bg = theme_color("TabLineFill", "bg"),
      },
      background = {
        bg = theme_color("NormalFloat", "bg"),
      },
      buffer_visible = {
        bg = theme_color("NormalFloat", "bg"),
      },
      buffer_selected = {
        fg = theme_color("Normal", "fg"),
        bg = theme_color("Normal", "bg"),
        bold = true,
        italic = false,
      },
      separator = {
        fg = theme_color("TabLineFill", "bg"),
        bg = theme_color("NormalFloat", "bg"),
      },
      separator_visible = {
        fg = theme_color("TabLineFill", "bg"),
        bg = theme_color("NormalFloat", "bg"),
      },
      separator_selected = {
        fg = theme_color("TabLineFill", "bg"),
        bg = theme_color("Normal", "bg"),
      },
      offset_separator = {
        fg = theme_color("TabLineFill", "bg"),
        bg = theme_color("NvimTreeNormal", "bg"),
      },
      close_button = {
        bg = theme_color("NormalFloat", "bg"),
      },
      close_button_visible = {
        bg = theme_color("NormalFloat", "bg"),
      },
      close_button_selected = {
        bg = theme_color("Normal", "bg"),
      },
      modified = {
        bg = theme_color("NormalFloat", "bg"),
      },
      modified_visible = {
        bg = theme_color("NormalFloat", "bg"),
      },
      modified_selected = {
        bg = theme_color("Normal", "bg"),
      },
    },
    options = {
      -- 允许上面的主题联动层次覆盖主题自带的 Bufferline 近黑色高亮。
      themable = false,
      -- 默认逻辑按 listed Buffer 数量判断，无法区分空白 Buffer 与真实文件。
      auto_toggle_bufferline = false,
      -- 标签从编辑区开始显示；文件树上方保留与侧栏同色的空白占位。
      offsets = {
        {
          filetype = "NvimTree",
          highlight = "NvimTreeNormal",
          separator = true,
        },
      },
      -- 复用 Snacks，避免 Bufferline 默认的 bdelete! 强制丢弃修改。
      close_command = delete_buffer,
      right_mouse_command = delete_buffer,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    local group = vim.api.nvim_create_augroup("BufferlineVisibility", { clear = true })
    local render_bufferline = _G.nvim_bufferline
    local last_file_win = {}

    local function is_file_window(win)
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_config(win).relative ~= "" then
        return false
      end

      local bufnr = vim.api.nvim_win_get_buf(win)
      return vim.bo[bufnr].buftype == ""
    end

    local function remember_file_window()
      local win = vim.api.nvim_get_current_win()
      if is_file_window(win) then
        last_file_win[vim.api.nvim_get_current_tabpage()] = win
      end
    end

    local function file_window(tabpage)
      local win = last_file_win[tabpage]
      if win and is_file_window(win) and vim.api.nvim_win_get_tabpage(win) == tabpage then
        return win
      end

      for _, candidate in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
        if is_file_window(candidate) then
          last_file_win[tabpage] = candidate
          return candidate
        end
      end
    end

    -- 聚焦文件树时仍以最后聚焦的文件窗口渲染，保留当前可见文件前的指示条。
    _G.nvim_bufferline = function()
      local current_buf = vim.api.nvim_get_current_buf()
      if vim.bo[current_buf].filetype == "NvimTree" then
        local win = file_window(vim.api.nvim_get_current_tabpage())
        if win then
          return vim.api.nvim_win_call(win, render_bufferline)
        end
      end

      return render_bufferline()
    end

    vim.api.nvim_create_autocmd("WinEnter", {
      group = group,
      desc = "记录最后聚焦的文件窗口",
      callback = function()
        remember_file_window()
        vim.schedule(vim.cmd.redrawtabline)
      end,
    })

    vim.api.nvim_create_autocmd(
      { "BufAdd", "BufDelete", "BufEnter", "BufFilePost", "BufModifiedSet", "TextChanged", "TextChangedI" },
      {
        group = group,
        desc = "根据真实文件 Buffer 切换 Bufferline",
        callback = function()
          -- 等待 Buffer 的新增、删除或属性变更完成后再统计。
          vim.schedule(update_visibility)
        end,
      }
    )

    -- 初始化可见性，后续由上方自动命令持续同步。
    remember_file_window()
    update_visibility()
  end,
}
