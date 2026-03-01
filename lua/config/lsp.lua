-- Remove global default key mapping
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf

    pcall(vim.keymap.del, "n", "grn", { buffer = bufnr })
    pcall(vim.keymap.del, "n", "gra", { buffer = bufnr })
    pcall(vim.keymap.del, "n", "grr", { buffer = bufnr })
    pcall(vim.keymap.del, "n", "gri", { buffer = bufnr })
    pcall(vim.keymap.del, "n", "gO",  { buffer = bufnr })
  end,
})
-- Create new keymapping for lsps
-- LspAttach: After an LSP Client performs "initialize" and attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local keymap = vim.keymap
    local lsp = vim.lsp
    local bufopts = { noremap = true, silent = true }

    keymap.set("n", "gr", lsp.buf.references, bufopts)
    keymap.set("n", "gd", lsp.buf.definition, bufopts)
    keymap.set("n", "<space>rn", lsp.buf.rename, bufopts)
    keymap.set("n", "K", lsp.buf.hover, bufopts)
    keymap.set("n", "<space>f", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, bufopts)
  end,
})

-- CursorHold: When the user doesn't press a key for the time specified with 'updatetime'
--             By default, `updatetime` is equal to 4000 ms
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
  end,
})

-- 自动格式化 go 代码
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({
      async = false,
      timeout_ms = 5000,
      filter = function(client)
        return client.name == "gopls"
      end,
    })
  end,
})

-- 启用 lsp
vim.lsp.enable({
  "gopls",
  "lua_ls",
  "ty",
})
