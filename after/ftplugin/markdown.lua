-- Markdown 默认折行，但不自动插入硬换行。
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- Markdown 的 Treesitter 折叠层级较深；自动扩展折叠列，避免单列空间不足时显示层级数字。
vim.opt_local.foldcolumn = "auto:7"
