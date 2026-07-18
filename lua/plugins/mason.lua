-- https://github.com/mason-org/mason.nvim
-- 安装和管理 Neovim 使用的 LSP、格式化器等外部工具。
--
-- 操作：
--   :Mason              打开工具管理界面
--   :MasonInstall <pkg> 安装工具
--   :MasonUpdate        更新工具仓库
--   :MasonLog           查看安装日志
--
-- NOTE: 网络失败不会影响 Neovim 启动；恢复后重新安装即可。
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "bashls",
      "docker_language_server",
      "gopls",
      "jsonls",
      "lua_ls",
      "marksman",
      "taplo",
      "ty",
      "yamlls",
    },
    -- Mason 只负责安装，启用列表由 vim.lsp.enable() 统一维护。
    automatic_enable = false,
  },
}
