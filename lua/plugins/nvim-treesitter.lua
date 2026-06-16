-- https://github.com/nvim-treesitter/nvim-treesitter
-- 语法树解析，语法高亮，textobjects、折叠等功能
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = {
      "bash",
      "go",
      "gomod",
      "lua",
      "toml",
      "yaml",
      "json",
      "python",
      "make",
      "dockerfile",
      "git_rebase",
      "gitcommit",
      "gitattributes",
      "gitignore",
      "diff",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
    },
    -- Automatically install missing parsers when entering the buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
    highlight = {
      -- Should we enable this module for all supported languages?
      enable = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      -- init_selection: in normal mode, start incremental selection.
      -- node_incremental: in visual mode, increment to the upper named parent.
      -- scope_incremental: in visual mode, increment to the upper scope
      -- node_decremental: in visual mode, decrement to the previous named node.
      keymaps = {
        init_selection = "gss",
        node_incremental = "gsi",
        scope_incremental = "gsc",
        node_decremental = "gsd",
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    -- Hints:
    --   A uppercase letter followed `z` means recursive
    --   zo: open one fold under the cursor
    --   zc: close one fold under the cursor
    --   za: toggle the folding
    --   zv: open just enough folds to make the line in which the cursor is located not folded
    --   zM: close all foldings
    --   zR: open all foldings
    -- source: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        if pcall(vim.treesitter.start) then
          vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.opt_local.foldmethod = "expr"
        end
      end,
    })
  end,
  build = ":TSUpdate",
}

