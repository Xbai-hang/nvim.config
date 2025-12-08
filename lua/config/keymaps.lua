-- 复用 opt 参数
local opt = {
  noremap = true, -- non-recursive
  silent = true, -- show message
}

-- 基础操作
vim.keymap.set("n", "<leader>p", ":set invpaste paste?<CR>", opt) -- 格式化文件中所有代码行（nvim-treesitter 代码格式化）

vim.keymap.set("n", "<leader>t", "gg=G", opt) -- 格式化文件中所有代码行（nvim-treesitter 代码格式化）

vim.keymap.set("i", "jk", "<ESC>", { desc = "Leave Insert mode" }) -- 退出 insert 模式

-- 显示行号
vim.keymap.set("n", "<leader><leader>", function()
  vim.wo.number = not vim.wo.number
end, { desc = "Toggle line numbers" })

-- 替代 gcc 的快捷键
-- vim.keymap.set("n", "<leader>c", "gcc", { noremap = true, silent = true })
-- 替代 gc% 的快捷键
-- vim.keymap.set("n", "<leader>cc", "gc%", { noremap = true, silent = true })

-- 窗口操作
-- 取消 s 默认功能
vim.keymap.set("n", "s", "", opt)

-- windows 分屏快捷键
vim.keymap.set("n", "sv", ":vsp<CR>", opt)
vim.keymap.set("n", "sh", ":sp<CR>", opt)
vim.keymap.set("n", "sc", "<C-w>c", opt) -- 关闭当前
vim.keymap.set("n", "so", "<C-w>o", opt) -- 关闭其他

-- 更改窗口大小
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>") -- Ctrl+上：窗口高度减小 2 行
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>") -- Ctrl+下：窗口高度增加 2 行
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>") -- Ctrl+左：窗口宽度减小 2 列
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>") -- Ctrl+右：窗口宽度增加 2 列

-- 简化窗口跳转快捷键
vim.keymap.set("n", "<A-Left>", "<C-w><C-h>", { desc = "Switch Left Window" })
vim.keymap.set("n", "<A-UP>", "<C-w><C-k>", { desc = "Switch Upper Window" })
vim.keymap.set("n", "<A-Down>", "<C-w><C-j>", { desc = "Switch Lower Window" })
vim.keymap.set("n", "<A-Right>", "<C-w><C-l>", { desc = "Switch Right Window" })

-- 切换 buffer 快捷键
vim.keymap.set("n", "<C-h>", ":bprevious<CR>", { desc = "Switch Previous buffer" })
vim.keymap.set("n", "<C-l>", ":bnext<CR>", { desc = "Switch Next buffer" })

-- insert 模式下，跳到行首行尾
vim.keymap.set("i", "<C-h>", "<ESC>I", opt)
vim.keymap.set("i", "<C-l>", "<ESC>A", opt)

-- Visual 模式下：增强缩进体验
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
-- Visual 模式下：上下移动选中文本
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv", opt)
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv", opt)

-- 清除高亮
vim.keymap.set("n", "<ESC>", vim.cmd.nohlsearch, { desc = "Clear Highlights" })

-- 简化退出、保存文件
vim.keymap.set({ "i", "x", "n", "s" }, "<C-q>", vim.cmd.quit, { desc = "Quit File" })
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", vim.cmd.write, { desc = "Save File" })

-- Go IDE
vim.keymap.set("n", "fe", ":GoIfErr<CR>", { desc = "Fill Struct in Go" })
vim.keymap.set("n", "fs", ":GoFillStruct<CR>", { desc = "Fill Struct in Go" })
vim.keymap.set("n", "<leader>fc", ":GoFillSwitch<CR>", { desc = "Fill Struct in Go" })
vim.keymap.set("n", "<leader>ta", ":GoAddTag<CR>", { desc = "Append Struct Tag in Go" })
vim.keymap.set("n", "<leader>tr", ":GoRmTag<CR>", { desc = "Remove Struct Tag in Go" })
vim.keymap.set("n", "<leader>tc", ":GoClearTag<CR>", { desc = "Clear Struct Tag in Go" })
vim.keymap.set("n", "<leader>i", ":GoImports<CR>", { desc = "Go imports" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Go to Definition" })
vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<CR>", { desc = "Go to Reference" })
vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", { desc = "Go to Implementation" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

-- FZF-Lua
vim.keymap.set("n", "<C-e>", "<cmd>FzfLua buffers<CR>", { desc = "Fzf: list buffers" })
vim.keymap.set("n", "ss", "<cmd>FzfLua live_grep<CR>", { desc = "Fzf: live_grep" })
vim.keymap.set("n", "gf", "<cmd>FzfLua files<CR>", { desc = "Fzf: search files" })
vim.keymap.set("n", "<C-f>", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "Fzf: grep buffer" })
vim.keymap.set("n", "<leader>r", "<cmd>FzfLua oldfiles<CR>", { desc = "Fzf: most recent used" })
vim.keymap.set("n", "<leader>s", "<cmd>FzfLua treesitter<CR>", { desc = "Fzf: treesitter" })
vim.keymap.set("n", "<leader>h", "<cmd>FzfLua search_history<CR>", { desc = "Fzf: search history" })
vim.keymap.set("n", "<leader>m", "<cmd>FzfLua marks<CR>", { desc = "Fzf: marks" })
vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Fzf: git commit" })
vim.keymap.set("n", "<leader>gb", "<cmd>FzfLua git_bcommits<CR>", { desc = "Fzf: git branch commit" })
vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Fzf: git status" })
