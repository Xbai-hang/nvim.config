# :sparkles: Nvim.config

个人使用的 Neovim (nvim) 配置文件，基于 **Lazy.nvim** 管理插件。

- **`Neovim` >= 0.12.0**，建议源码编译

## :rocket: QuickStart

```shell
# 将本仓库克隆到 Neovim 配置路径下
git clone https://github.com/Xbai-hang/nvim.config ~/.config/nvim
```

首次启动 Neovim 后，`lazy.nvim` 会自动安装所有插件。

拉取配置更新后，执行 `:Lazy restore` 将插件恢复到 `lazy-lock.json` 锁定的版本。

## :hammer_and_wrench: 安装与部署

### 1. 安装 Neovim (推荐源码编译)

```shell
# 1. 克隆 Neovim 仓库
git clone https://github.com/neovim/neovim /tmp/neovim 
cd /tmp/neovim 

# 2. 编译 Neovim (需要 cmake)
# 使用 RelWithDebInfo 模式，平衡性能与可调试性
make CMAKE_BUILD_TYPE=RelWithDebInfo 

# 3. 安装到系统
sudo make install
nvim --version

# 4. 设置默认命令行编辑器，影响 git commit 等行为
alias vi='nvim'
alias vim='nvim'
export EDITOR=nvim
```

### 2. 安装二进制文件（可选，解锁完整能力）

#### macOS（Homebrew）

```shell
brew install fzf ripgrep fd bat stylua lazygit git-delta trash-cli \
  mermaid-cli tree-sitter-cli curl gnu-tar unzip gzip
```

#### Debian（apt、Cargo、npm）

```shell
sudo apt update && apt install -y fzf ripgrep fd-find bat lazygit curl tar unzip gzip cargo nodejs npm

cargo install --locked stylua git-delta tree-sitter-cli
npm install --global @mermaid-js/mermaid-cli trash-cli
```

Debian 可能将 `fd` 和 `bat` 安装为 `fdfind` 和 `batcat`，可补充用户级命令链接：

```shell
mkdir -p ~/.local/bin
ln -sf "$(command -v fdfind)" ~/.local/bin/fd
ln -sf "$(command -v batcat)" ~/.local/bin/bat
```

#### Fedora（dnf、Cargo、npm）

```shell
sudo dnf copr enable dejan/lazygit -y
sudo dnf install -y fzf ripgrep fd-find bat lazygit curl tar unzip gzip cargo nodejs npm

cargo install --locked stylua git-delta tree-sitter-cli
npm install --global @mermaid-js/mermaid-cli trash-cli
```

#### Windows（Scoop、Cargo、npm）

在 PowerShell 中执行：

```powershell
scoop bucket add extras
scoop install fzf ripgrep fd bat stylua lazygit delta curl tar unzip gzip rustup nodejs-lts

cargo install --locked tree-sitter-cli
npm install --global @mermaid-js/mermaid-cli trash-cli
```

安装后应能直接执行 `fzf`、`rg`、`fd`、`bat`、`stylua`、`lazygit`、`delta`、`trash`、`mmdc` 和 `tree-sitter`。


## :gear: 配置目录结构

| 文件/目录 | 说明 |
| :--- | :--- |
| `init.lua` | 配置入口。 |
| `lua/config/` | Neovim 核心配置。 |
| `lua/plugins/` | lazy.nvim 插件配置。 |
| `after/ftplugin/` | 按文件类型设置局部选项。 |
| `after/lsp/` | 扩展各语言服务器的默认配置。 |

### 1. 核心配置 `lua/config/`

| 文件名 | 说明 |
| :--- | :--- |
| `options.lua` | 全局选项。 |
| `keymaps.lua` | 全局快捷键。 |
| `lazy.lua` | 插件管理器。 |
| `colorscheme.lua` | 主题配置。 |
| `lsp.lua` | 启用 LSP 并配置公共行为。 |

### 2. 文件类型配置 `after/ftplugin/`

Neovim 识别文件类型后，会自动加载同名配置，例如 `after/ftplugin/go.lua`。新增配置时创建对应的 `<filetype>.lua`，并使用 `vim.opt_local` 设置局部选项，无需在 `init.lua` 中引入。

### 3. LSP 配置 `after/lsp/`

同名文件会扩展 nvim-lspconfig 的默认配置，例如 `after/lsp/gopls.lua`。新增 LSP 时，使用 Mason 安装对应服务，创建同名配置文件，再将名称加入 `vim.lsp.enable()`。

## :package: 集成插件列表 (plugins/)

| 插件文件 | 仓库/文档 | 功能描述 |
| :--- | :--- | :--- |
| `ai-coding.lua` | [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua) | AI 行内补全。 |
| `autopairs.lua` | [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) | 自动补全括号、引号等成对字符。 |
| `blame.lua` | [FabijanZulj/blame.nvim](https://github.com/FabijanZulj/blame.nvim) | 查看文件 Git 归属与提交历史。 |
| `blink.cmp.lua` | [Saghen/blink.cmp](https://github.com/Saghen/blink.cmp) | 代码补全引擎。 |
| `bufferline.lua` | [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | 顶部 Buffer 标签栏。 |
| `conform.lua` | [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | 代码格式化框架。 |
| `fzf.lua` | [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) | 文件、文本、Git 和 LSP 模糊查找。 |
| `gitsigns.lua` | [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | 显示并操作 Git 变更块。 |
| `guess-indent.lua` | [nmac427/guess-indent.nvim](https://github.com/nmac427/guess-indent.nvim) | 自动猜测已有文件缩进。 |
| `ident-blankline.lua` | [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | 显示缩进线和当前作用域。 |
| `lualine.lua` | [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 底部状态栏。 |
| `mason.lua` | [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) | 安装和管理 LSP 等外部工具。 |
| `nvim-tree.lua` | [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | 文件树与目录浏览。 |
| `nvim-treesitter.lua` | [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法高亮、折叠、缩进和语言注入。 |
| `render-markdown.lua` | [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | 在 Neovim 内渲染 Markdown。 |
| `rootdir.lua` | [Neovim Lua API](https://neovim.io/doc/user/lua.html) | 匹配并设置项目根目录。 |
| `snacks.lua` | [folke/snacks.nvim](https://github.com/folke/snacks.nvim) | 启动页、通知、终端、Lazygit 和图片预览。 |
| `todo-comments.lua` | [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | 高亮并搜索结构化注释。 |
| `tokyonight.theme.lua` | [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | 主题配置。 |
| `whichkey.lua` | [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | 快捷键分组与提示。 |

### 已移除插件

| 插件文件 | 仓库/文档 | 功能描述 | Desc |
| :--- | :--- | :--- | :--- |
| `alpha.lua` | [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) | 启动页。 | 已移除：改由 snacks.lua 提供。 |
| `comment.lua` | [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) | 快速注释与取消注释。 | 已移除：改用 Neovim 原生注释。 |
| `go.nvim.lua` | [ray-x/go.nvim](https://github.com/ray-x/go.nvim) | Go 开发集成。 | 已移除：能力拆分到 LSP、Treesitter 和 Conform。 |
| `markdown-glow.lua` | [ellisonleao/glow.nvim](https://github.com/ellisonleao/glow.nvim) | Glow Markdown 预览。 | 已移除：与当前 Markdown 阅读链重复。 |
| `markdown.lua` | [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | 浏览器 Markdown 预览。 | 已移除：不再维护额外的浏览器预览链。 |
| `markview.lua` | [OXY2DEV/markview.nvim](https://github.com/OXY2DEV/markview.nvim) | Markdown 渲染。 | 已移除：对比后保留 render-markdown.lua。 |
| `notify.lua` | [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) | 通知界面。 | 已移除：通知统一由 snacks.lua 提供。 |
| `telescope.lua` | [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 模糊查找。 | 已移除：搜索统一由 fzf.lua 提供。 |
| `toggleterm.lua` | [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | 集成终端。 | 已移除：终端统一由 snacks.lua 提供。 |

## :books: 额外的学习资源

  * **Lua 教程**：可以在 Neovim 中使用 `:h lua-guide` 查看官方 Lua 教程。
  * **Vim 迁移指南**：`:help nvim-from-vim` 提供了从 Vim 迁移到 Neovim 的指导。
  * ....
