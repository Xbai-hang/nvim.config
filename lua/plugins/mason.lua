-- https://github.com/mason-org/mason.nvim
-- mason 用于管理、下载 lsp
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = { "gopls" },
    automatic_enable = false,
  },
}
