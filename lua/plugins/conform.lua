-- https://github.com/stevearc/conform.nvim
-- 统一调用外部格式化器，并在没有可用工具时回退到 LSP。
--
-- 使用方法：
--   <leader>ff   格式化当前文件或 Visual 模式选区
--   <leader>uf   切换当前 Buffer 的保存时格式化
--   :ConformInfo 查看当前文件将使用的格式化器及日志
--   :FormatDisable[!] 全局关闭；加 ! 仅关闭当前 Buffer
--   :FormatEnable     重新启用保存时格式化
local function format_on_save(bufnr)
  if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    return
  end

  return {
    timeout_ms = 1000,
    -- 未配置 formatter 的文件保存时静默跳过，手动格式化仍会提示。
    quiet = true,
  }
end

return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  event = "BufWritePre",
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({
          async = true,
          lsp_format = "fallback",
        })
      end,
      mode = { "n", "v" },
      desc = "格式化代码",
    },
    {
      "<leader>uf",
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        vim.notify(
          vim.b.disable_autoformat and "已关闭当前 Buffer 保存时格式化"
            or "已启用当前 Buffer 保存时格式化"
        )
      end,
      desc = "切换保存时格式化",
    },
  },
  opts = {
    formatters_by_ft = {
      -- goimports 可整理 import；未安装时使用 Go 自带的 gofmt。
      go = { "goimports", "gofmt", stop_after_first = true },
      lua = { "stylua" },
      python = { "isort", "black" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = format_on_save,
    notify_on_error = true,
    notify_no_formatters = true,
  },
  init = function()
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { bang = true, desc = "关闭保存时格式化（! 仅当前 Buffer）" })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "启用保存时格式化" })
  end,
}
