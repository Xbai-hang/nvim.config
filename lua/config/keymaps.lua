local function map(mode, lhs, rhs, desc, opts)
  opts = vim.tbl_extend("force", { noremap = true, silent = true, desc = desc }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- 基础编辑
map("i", "jk", "<ESC>", "退出插入模式")
map("n", "<leader>ul", function()
  vim.wo.number = not vim.wo.number
end, "打开/关闭行号显示")
map("n", "<leader>uw", function()
  vim.wo.list = not vim.wo.list
end, "显示/隐藏空白字符（Whitespace）")
map("n", "<leader>uW", function()
  local enabled = not vim.wo.wrap
  vim.wo.wrap = enabled
  vim.b.wrap_override = enabled
end, "打开/关闭自动折行（Wrap）")
map("n", "<ESC>", vim.cmd.nohlsearch, "清除搜索高亮")
map({ "x", "n", "s" }, "<C-q>", vim.cmd.quit, "退出当前窗口")
map({ "i", "x", "n", "s" }, "<C-s>", "<Esc><Cmd>write<CR>", "保存文件并返回普通模式")
map("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, "向下移动一个显示行", { expr = true })
map("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, "向上移动一个显示行", { expr = true })

-- 窗口与 Buffer
map("n", "<leader>wv", "<Cmd>vsplit<CR>", "左右分屏")
map("n", "<leader>wh", "<Cmd>split<CR>", "上下分屏")
map("n", "<leader>wc", "<C-w>c", "关闭当前窗口")
map("n", "<leader>wo", "<C-w>o", "只保留当前窗口")
map("n", "<leader>we", "<C-w>=", "均衡窗口尺寸")
map("n", "<leader>ww", "<C-w>w", "切换到下一个窗口")
-- 移动当前窗口位置可使用 Neovim 原生 <C-w>H/J/K/L。

map("n", "<C-Up>", ":resize -2<CR>", "减小窗口高度")
map("n", "<C-Down>", ":resize +2<CR>", "增加窗口高度")
map("n", "<C-Left>", ":vertical resize -2<CR>", "减小窗口宽度")
map("n", "<C-Right>", ":vertical resize +2<CR>", "增加窗口宽度")

-- 普通窗口和终端窗口共用导航键，无需先退出终端输入模式。
map({ "n", "t" }, "<A-Left>", "<Cmd>wincmd h<CR>", "切换到左侧窗口")
map({ "n", "t" }, "<A-Up>", "<Cmd>wincmd k<CR>", "切换到上方窗口")
map({ "n", "t" }, "<A-Down>", "<Cmd>wincmd j<CR>", "切换到下方窗口")
map({ "n", "t" }, "<A-Right>", "<Cmd>wincmd l<CR>", "切换到右侧窗口")
map("n", "<C-a>", "^", "跳转到首个非空字符")
map("n", "<C-e>", "$", "跳转到行尾")
map("i", "<C-a>", "<C-o>^", "跳转到首个非空字符")
map("i", "<C-e>", "<C-o>$", "跳转到行尾")

-- Visual 模式：操作后保留选区，便于连续调整。
map("x", "<", "<gv", "减少缩进并保持选区")
map("x", ">", ">gv", "增加缩进并保持选区")
map("x", "K", ":move '<-2<CR>gv=gv", "向上移动选中行并重新缩进")
map("x", "J", ":move '>+1<CR>gv=gv", "向下移动选中行并重新缩进")

-- 代码折叠：沿用 Neovim 原生 z 前缀，并补充描述供 WhichKey 展示。
map("n", "za", "za", "切换当前折叠")
map("n", "zo", "zo", "展开当前折叠")
map("n", "zO", "zO", "递归展开当前折叠")
map("n", "zc", "zc", "折叠当前区域")
map("n", "zC", "zC", "递归折叠当前区域")
map("n", "zR", "zR", "展开全部折叠")
map("n", "zM", "zM", "折叠全部区域")
