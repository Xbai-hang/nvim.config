-- https://github.com/nmac427/guess-indent.nvim
-- 自动识别现有文件的缩进；项目声明 EditorConfig 缩进规则时自动跳过。
--
-- 优先级：
--   1. 项目 EditorConfig 明确声明的缩进规则
--   2. GuessIndent 根据当前 Buffer 内容推断
--   3. 推断失败时保留 Neovim filetype 或全局默认值
--
-- 操作：
--   :GuessIndent context  尊重 EditorConfig，仅在缺少缩进规则时重新推断
--   :GuessIndent          强制重新推断，可能覆盖当前 Buffer 的 EditorConfig 结果
--
-- NOTE: 插件需要在首次 BufReadPost/BufNewFile 前注册自动命令，因此不懒加载。
return {
  "nmac427/guess-indent.nvim",
  lazy = false,
  opts = {
    auto_cmd = true,
    override_editorconfig = false,
  },
}
