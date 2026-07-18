-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/docker_language_server.lua
-- Docker LS：Dockerfile/Compose；Mason 安装，lua/config/lsp.lua 启用。
vim.filetype.add({
  filename = {
    ["compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["docker-compose.yml"] = "yaml.docker-compose",
  },
})

---@type vim.lsp.Config
return {}
