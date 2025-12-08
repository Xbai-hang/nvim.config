-- https://github.com/notjedi/nvim-rooter.lua
-- 匹配项目根目录，方便 fzf 范围搜索
-- NOTE: avoid lazy loading as the autocmds may not be caught by nvim-rooter.lua.
return {
  "notjedi/nvim-rooter.lua",
  config = function()
    require("nvim-rooter").setup({
      rooter_patterns = { ".git", ".hg", ".svn" },
      trigger_patterns = { "*" },
      manual = false,
      fallback_to_parent = false,
      cd_scope = "global",
    })
  end,
}
