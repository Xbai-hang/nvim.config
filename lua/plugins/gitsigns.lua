-- https://github.com/lewis6991/gitsigns.nvim
-- 在 Sign Column 显示 Git 变更，并提供变更块（Hunk）的导航、预览、暂存与恢复操作。
--
-- 标记：
--   ┃  未暂存的新增或修改
--   │  已暂存的新增或修改
--   ┆  Git 仓库内尚未跟踪的新文件
--   _/‾/~  删除、顶部删除、修改后删除
--
-- 操作：
--   [h/<leader>ghp  跳到上一个/预览当前 Git 变更块（Hunk）
--   ]h/<leader>ghi  跳到下一个/行内预览当前 Git 变更块（Hunk）
--   <leader>ghs     暂存或取消暂存当前 Git 变更块（普通模式或可视选择）
--   <leader>ghR     恢复当前 Git 变更块（危险操作，普通模式或可视选择）
--   <leader>ghb     查看当前行的完整 Git 归属
--   <leader>ghd     对比当前文件与 Git Index
--   ih              在操作符等待或可视模式中选择 Git 变更块
local function on_attach(bufnr)
  local gitsigns = require("gitsigns")

  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      silent = true,
      desc = desc,
    })
  end

  map("n", "]h", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gitsigns.nav_hunk("next")
    end
  end, "跳到下一个 Git 变更块（Hunk）")

  map("n", "[h", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gitsigns.nav_hunk("prev")
    end
  end, "跳到上一个 Git 变更块（Hunk）")

  map("n", "<leader>ghp", gitsigns.preview_hunk, "预览 Git 变更块（Hunk）")
  map("n", "<leader>ghi", gitsigns.preview_hunk_inline, "行内预览 Git 变更块（Hunk）")
  map("n", "<leader>ghs", gitsigns.stage_hunk, "切换暂存 Git 变更块（Hunk）")
  map("x", "<leader>ghs", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, "切换暂存选中 Git 变更块（Hunk）")
  map("n", "<leader>ghR", gitsigns.reset_hunk, "恢复 Git 变更块（Hunk）")
  map("x", "<leader>ghR", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, "恢复选中 Git 变更块（Hunk）")
  map("n", "<leader>ghb", function()
    gitsigns.blame_line({ full = true })
  end, "查看当前行 Git 归属（Blame）")
  map("n", "<leader>ghd", gitsigns.diffthis, "对比文件与 Git Index")
  map({ "o", "x" }, "ih", gitsigns.select_hunk, "选择 Git 变更块（Hunk）")
end

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    -- 已暂存内容使用细线，即使主题颜色不明显也能与未暂存内容区分。
    signs_staged = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    -- 让仓库内的新文件也显示未跟踪标记；Git 仓库之外的文件不会附加 Gitsigns。
    attach_to_untracked = true,
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    preview_config = {
      border = "rounded",
    },
    on_attach = on_attach,
  },
}
