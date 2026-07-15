-- 使用 Neovim 原生 API 管理项目根目录，不依赖外部插件。
-- 窗口级工作目录会被 FzfLua、nvim-tree、Snacks terminal 和外部命令共同使用。
--
-- 根目录策略：
--   1. 优先使用人为放置的 .project-root 标记。
--   2. 向上查找最近的 Git、Jujutsu、Mercurial 或 Subversion 仓库。
--   3. 找不到项目标记时，回退到当前文件所在目录。
--
-- 操作：
--   :pwd          查看当前窗口的工作目录
--   :Rooter       重新识别并应用当前 Buffer 的根目录
--   :RooterToggle 在项目根目录与当前文件所在目录之间切换
--   :RootInfo     查看根目录、识别来源和当前窗口工作目录
local M = {}

local explicit_marker = ".project-root"
local vcs_markers = { ".git", ".jj", ".hg", ".svn" }

---@param bufnr integer
---@return string?
local function buffer_path(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
    return nil
  end

  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then
    return nil
  end

  return vim.fs.normalize(path)
end

---@param path string
---@return string root
---@return string source
local function detect_root(path)
  local root = vim.fs.root(path, explicit_marker)
  if root then
    return root, explicit_marker
  end

  -- 嵌套列表表示这些 VCS 标记优先级相同，选择路径上最近的一项。
  root = vim.fs.root(path, { vcs_markers })
  if root then
    for _, marker in ipairs(vcs_markers) do
      if vim.uv.fs_stat(vim.fs.joinpath(root, marker)) then
        return root, marker
      end
    end
    return root, "版本控制标记"
  end

  local stat = vim.uv.fs_stat(path)
  if stat and stat.type == "directory" then
    return path, "当前目录"
  end
  return vim.fs.dirname(path), "文件所在目录"
end

---@param root string
local function change_window_dir(root)
  if vim.fn.getcwd(0) ~= root then
    vim.fn.chdir(root, "window")
  end
end

---@param bufnr? integer
---@return string? root
---@return string? source
function M.apply(bufnr)
  bufnr = bufnr or 0
  local path = buffer_path(bufnr)
  if not path then
    return nil, nil
  end

  local root, source = detect_root(path)
  change_window_dir(root)
  vim.b[bufnr].project_root = root
  vim.b[bufnr].project_root_source = source
  return root, source
end

local function setup()
  local group = vim.api.nvim_create_augroup("NativeRootDir", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
    group = group,
    desc = "根据当前文件更新窗口级项目根目录",
    callback = function(args)
      M.apply(args.buf)
    end,
  })

  vim.api.nvim_create_user_command("Rooter", function()
    local root, source = M.apply(0)
    if root then
      vim.notify(("项目根目录：%s（%s）"):format(root, source))
    else
      vim.notify("当前 Buffer 没有可识别的文件路径", vim.log.levels.WARN)
    end
  end, { desc = "重新识别项目根目录", force = true })

  vim.api.nvim_create_user_command("RooterToggle", function()
    local path = buffer_path(0)
    if not path then
      vim.notify("当前 Buffer 没有可识别的文件路径", vim.log.levels.WARN)
      return
    end

    local stat = vim.uv.fs_stat(path)
    local parent = stat and stat.type == "directory" and path or vim.fs.dirname(path)
    local root = detect_root(path)
    change_window_dir(vim.fn.getcwd(0) == parent and root or parent)
  end, { desc = "切换项目根目录与文件目录", force = true })

  vim.api.nvim_create_user_command("RootInfo", function()
    local path = buffer_path(0)
    if not path then
      vim.notify("当前 Buffer 没有可识别的文件路径", vim.log.levels.WARN)
      return
    end

    local root, source = detect_root(path)
    vim.notify(
      table.concat({
        "文件：" .. path,
        "根目录：" .. root,
        "识别来源：" .. source,
        "窗口 cwd：" .. vim.fn.getcwd(0),
      }, "\n"),
      vim.log.levels.INFO,
      { title = "RootInfo" }
    )
  end, { desc = "查看项目根目录信息", force = true })
end

return {
  name = "native-rootdir",
  dir = vim.fn.stdpath("config"),
  virtual = true,
  lazy = false,
  config = setup,
}
