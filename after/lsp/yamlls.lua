-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/yamlls.lua
-- YAML LS：YAML；Mason 安装，lua/config/lsp.lua 启用。
---@type vim.lsp.Config
return {
  -- Compose 交给 Docker LS，避免两个服务重复处理。
  filetypes = {
    "yaml",
    "yaml.gitlab",
    "yaml.helm-values",
  },
}
