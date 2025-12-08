-- 主题预览：https://vimcolorschemes.com/i/trending
-- 可选主题：["tokyonight-moon", ...]
local colorscheme = "tokyonight-storm"
local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
