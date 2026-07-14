-- https://github.com/zbirenbaum/copilot.lua
-- NOTE:GitHub Copilot 的原生 Lua 客户端；使用 :Copilot auth 登录。
-- 若以后需要自定义 LLM Provider，可迁移到 milanglacier/minuet-ai.nvim。
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    -- Blink 负责常规补全，Copilot 只显示行内建议。
    panel = {
      enabled = false,
    },

    suggestion = {
      enabled = true,
      auto_trigger = true,

      -- Blink 补全菜单出现时隐藏 Copilot，避免两套补全重叠。
      hide_during_completion = true,

      keymap = {
        -- 快捷键接受 ai 建议
        accept = "<C-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },

    -- 这些类型插件本身默认也会禁用，这里显式声明便于维护。
    filetypes = {
      help = false,
      gitcommit = false,
      gitrebase = false,
    },

    -- 保留插件默认的 Buffer 检查，并排除可能包含凭据的 .env 文件。
    should_attach = function(bufnr, bufname)
      if not vim.bo[bufnr].buflisted then
        return false
      end

      if vim.bo[bufnr].buftype ~= "" then
        return false
      end

      return not vim.fs.basename(bufname):match("^%.env")
    end,

    logger = {
      file_log_level = vim.log.levels.WARN,
      print_log_level = vim.log.levels.ERROR,
    },
  },
}
