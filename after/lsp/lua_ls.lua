-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
-- LuaLS：Lua；Mason 安装，lua/config/lsp.lua 启用。
---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        -- 按 Neovim 的模块目录解析 require("foo")。
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}
