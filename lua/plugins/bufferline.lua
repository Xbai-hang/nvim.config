-- https://github.com/akinsho/bufferline.nvim
-- 在顶部显示已打开的 Buffer。
--
-- 操作：
--   <C-h>/<C-l> 切换上一个/下一个 Buffer
--   <leader>bd   安全删除当前 Buffer
--   左键点击      切换 Buffer
--   关闭按钮/右键 安全删除 Buffer
local function delete_buffer(bufnr)
  require("snacks").bufdelete(bufnr)
end

return {
  "akinsho/bufferline.nvim",
  -- 跟随最新稳定 tag；lazy-lock.json 仍会锁定具体 commit。
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/snacks.nvim",
  },
  keys = {
    { "<C-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "切换到上一个 Buffer" },
    { "<C-l>", "<cmd>BufferLineCycleNext<CR>", desc = "切换到下一个 Buffer" },
    {
      "<leader>bd",
      function()
        delete_buffer()
      end,
      desc = "删除当前 Buffer",
    },
  },
  opts = {
    options = {
      -- 复用 Snacks，避免 Bufferline 默认的 bdelete! 强制丢弃修改。
      close_command = delete_buffer,
      right_mouse_command = delete_buffer,
    },
  },
}
