-- LSP 连接当前 Buffer 后再创建专属快捷键，避免占用普通文件的按键。
local lsp_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  desc = "创建当前 Buffer 的 LSP 快捷键",
  callback = function(args)
    local lsp = vim.lsp
    local bufnr = args.buf

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, {
        buffer = bufnr,
        noremap = true,
        silent = true,
        desc = desc,
      })
    end

    map("<leader>rn", lsp.buf.rename, "重命名符号（LSP）")
    map("K", lsp.buf.hover, "显示悬浮文档（LSP）")
    map("<leader>ld", function()
      vim.diagnostic.open_float({
        focusable = true,
        source = "if_many",
        border = "rounded",
      })
    end, "查看当前行诊断（Diagnostics）")
  end,
})

-- 启用 lsp
vim.lsp.enable({
  "bashls",
  "docker_language_server",
  "gopls",
  "jsonls",
  "lua_ls",
  "marksman",
  "taplo",
  "ty",
  "yamlls",
})
