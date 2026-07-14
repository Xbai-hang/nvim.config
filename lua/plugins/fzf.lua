-- https://github.com/ibhagwan/fzf-lua
-- 使用 fzf 提供文件、文本、Buffer、Git、LSP 等统一搜索界面。
--
-- NOTE: 该插件是 Neovim 前端，必须能从 $PATH 找到 fzf 可执行文件，
-- 否则所有 FzfLua Picker 都无法工作。
--
-- 外部程序：
--   fzf       必需，负责模糊筛选界面
--   rg        推荐，负责高速文本搜索
--   fd        推荐，负责高速文件查找
--   git       Git Picker 必需
--   bat       可选，提供语法高亮预览
--   delta     可选，优化 Git 差异预览
--
-- 搜索：
--   <leader>fzf  查找文件
--   <leader>fzg  查找 Git 跟踪文件
--   <leader>fzc  全局文本搜索
--   <leader>fzb  搜索已打开的 Buffer
--   <leader>fzl  搜索当前 Buffer 内容
--   <leader>fzo  查看最近文件
--   <leader>fzt  搜索当前文件的 Treesitter 符号
--   <leader>fzh  搜索历史
--   <leader>fzm  搜索 Marks
--   <leader>fzr  恢复上一次 Picker 和查询
--
-- LSP：
--   以下快捷键仅在 LSP 连接当前 Buffer 后生效：
--   gd           查找定义
--   grr          查找引用
--   gri          查找实现
--   grt          查找类型定义
--   gD           查找声明
--
-- Git：
--   <leader>gl   搜索仓库提交历史（Git Log）
--   <leader>gf   搜索当前文件提交历史（Git File）
--   <leader>gs   查看 Git 状态
return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    local group = vim.api.nvim_create_augroup("FzfLuaLspKeymaps", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(args)
        local function map(lhs, picker, desc)
          vim.keymap.set("n", lhs, "<cmd>FzfLua " .. picker .. "<CR>", {
            buffer = args.buf,
            silent = true,
            desc = desc,
          })
        end

        map("gd", "lsp_definitions", "查找定义")
        map("grr", "lsp_references", "查找引用")
        map("gri", "lsp_implementations", "查找实现")
        map("grt", "lsp_typedefs", "查找类型定义")
        map("gD", "lsp_declarations", "查找声明")
      end,
    })
  end,
  opts = {},
  keys = {
    { "<leader>fzf", "<cmd>FzfLua files<CR>", desc = "查找文件" },
    { "<leader>fzg", "<cmd>FzfLua git_files<CR>", desc = "查找 Git 文件" },
    { "<leader>fzc", "<cmd>FzfLua live_grep<CR>", desc = "全局文本搜索" },
    { "<leader>fzb", "<cmd>FzfLua buffers<CR>", desc = "搜索已打开 Buffer" },
    { "<leader>fzl", "<cmd>FzfLua lgrep_curbuf<CR>", desc = "搜索当前 Buffer" },
    { "<leader>fzo", "<cmd>FzfLua oldfiles<CR>", desc = "查看最近文件" },
    { "<leader>fzt", "<cmd>FzfLua treesitter<CR>", desc = "搜索 Treesitter 符号" },
    { "<leader>fzh", "<cmd>FzfLua search_history<CR>", desc = "搜索历史" },
    { "<leader>fzm", "<cmd>FzfLua marks<CR>", desc = "搜索 Marks" },
    { "<leader>fzr", "<cmd>FzfLua resume<CR>", desc = "恢复上次搜索" },
    { "<leader>gl", "<cmd>FzfLua git_commits<CR>", desc = "搜索仓库提交历史" },
    { "<leader>gf", "<cmd>FzfLua git_bcommits<CR>", desc = "搜索当前文件提交历史" },
    { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "查看 Git 状态" },
  },
}
