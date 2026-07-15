-- https://github.com/nvim-treesitter/nvim-treesitter
-- 提供语法高亮、语言注入、代码折叠和缩进。
--
-- 操作：
--   :TSInstall <language>   安装指定语言的 Parser
--   :TSUpdate [language]    更新指定语言或全部已安装 Parser
--   :TSUninstall <language> 卸载指定语言的 Parser
--   :TSLog                  查看安装、更新与卸载日志
--   :checkhealth nvim-treesitter 检查运行环境、Parser 和 Query
--
-- 外部依赖：
--   curl、tar、tree-sitter-cli >= 0.26.1，以及可用的 C 编译器。
--
-- NOTE: 缺少 Parser 时会提示对应的 :TSInstall 命令，不会自动安装。
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  -- main 分支不支持懒加载；提前注册 FileType，确保首个 Buffer 也能启动 Treesitter。
  lazy = false,
  -- 插件 Query 与 Parser 版本需要同步，更新插件后自动更新已安装 Parser。
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    -- 使用官方 Parser 清单作为通用白名单，避免手动维护语言列表。
    local available = {}
    for _, lang in ipairs(ts.get_available()) do
      available[lang] = true
    end

    -- 部分 Neovim filetype 名称与 Treesitter Parser 名称不同。
    local aliases = {
      javascriptreact = "jsx",
      typescriptreact = "tsx",
    }

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = aliases[ft] or vim.treesitter.language.get_lang(ft)

        if not available[lang] then
          return
        end

        -- 不自动联网安装；每次按公开 API 查询，以便当前会话安装后立即生效。
        if not vim.list_contains(ts.get_installed("parsers"), lang) then
          -- 同一个 Buffer 只提示一次，避免 FileType 重新触发时重复通知。
          if not vim.b[args.buf].treesitter_missing then
            vim.b[args.buf].treesitter_missing = true
            vim.notify(("Treesitter parser 未安装：:TSInstall %s"):format(lang), vim.log.levels.WARN)
          end
          return
        end

        -- start() 启用原生高亮和语言注入；成功后再启用依赖语法树的折叠与缩进。
        if pcall(vim.treesitter.start, args.buf, lang) then
          vim.api.nvim_set_option_value("foldmethod", "expr", { scope = "local", win = 0 })
          vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.treesitter.foldexpr()", { scope = "local", win = 0 })
          vim.api.nvim_set_option_value(
            "indentexpr",
            "v:lua.require'nvim-treesitter'.indentexpr()",
            { scope = "local", buf = args.buf }
          )
        end
      end,
    })
  end,
}
