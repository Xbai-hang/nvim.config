-- https://github.com/ray-x/go.nvim
-- Go 语言开发环境集成
return {
  "ray-x/go.nvim",
  dependencies = { -- 依赖项修正
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "go", "gomod" },
  config = function()
    require("go").setup({
      verbose = false,
      diagnostic = { -- set diagnostic to false to disable vim.diagnostic.config setup,
        -- true: default nvim setup
        hdlr = false, -- hook lsp diag handler and send diag to quickfix
        underline = true,
        virtual_text = { spacing = 2, prefix = "" }, -- virtual text setup
        signs = { "", "", "", "" }, -- set to true to use default signs, an array of 4 to specify custom signs
        update_in_insert = false,
      },
      dap_debug = false,
    })
  end,
}
