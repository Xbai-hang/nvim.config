-- https://github.com/folke/todo-comments.nvim
-- 高亮并搜索代码注释中的结构化标记。
--
-- 默认标记：TODO、FIX、HACK、WARN、PERF、NOTE、TEST。
-- 自定义标记：REVIEW，用于记录合并或发布前需要人工复核的代码，例如：
--  REVIEW: 确认事务失败时能够完整回滚。
--
-- 操作：
--   [t           跳到上一个注释标记
--   ]t           跳到下一个注释标记
--   <leader>fca 查找全部注释标记
--   <leader>fct 查找待办（TODO）注释
--   <leader>fcn 查找备注（NOTE/INFO）注释
--   <leader>fcf 查找待修复（FIX/FIXME/BUG/ISSUE）注释
--   <leader>fcw 查找警告（WARN/WARNING/XXX）注释
--   <leader>fch 查找临时方案（HACK）注释
--   <leader>fcr 查找待复核（REVIEW/REVIEWME）注释
-- 标记样式预览：
-- PERF: fully optimized
-- HACK: this is weird
-- TODO: things to be done
-- NOTE: add a note here
-- FIX: this need fixing
-- WARNING: warning
-- REVIEW: needs a human review
local function find_comments(keywords)
  return function()
    require("todo-comments.fzf").todo({ keywords = keywords })
  end
end

return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      REVIEW = {
        icon = " ",
        color = "hint",
        alt = { "REVIEWME" },
      },
    },
  },
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "下一个注释标记",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "上一个注释标记",
    },
    {
      "<leader>fca",
      find_comments(),
      desc = "查找全部注释标记",
    },
    {
      "<leader>fct",
      find_comments({ "TODO" }),
      desc = "查找待办（TODO）注释",
    },
    {
      "<leader>fcn",
      find_comments({ "NOTE", "INFO" }),
      desc = "查找备注（NOTE/INFO）注释",
    },
    {
      "<leader>fcf",
      find_comments({ "FIX", "FIXME", "BUG", "FIXIT", "ISSUE" }),
      desc = "查找待修复（FIX/FIXME/BUG/ISSUE）注释",
    },
    {
      "<leader>fcw",
      find_comments({ "WARN", "WARNING", "XXX" }),
      desc = "查找警告（WARN/WARNING/XXX）注释",
    },
    {
      "<leader>fch",
      find_comments({ "HACK" }),
      desc = "查找临时方案（HACK）注释",
    },
    {
      "<leader>fcr",
      find_comments({ "REVIEW", "REVIEWME" }),
      desc = "查找待复核（REVIEW/REVIEWME）注释",
    },
  },
}
