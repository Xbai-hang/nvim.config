# :sparkles: Nvim.config

个人使用的 Neovim (nvim) 配置文件，基于 **LazyVim** 管理插件。

## :rocket: QuickStart

```bash
# 将本仓库克隆到 Neovim 配置路径下
git clone https://github.com/Xbai-hang/nvim.config ~/.config/nvim
```

首次启动 Neovim 后，`lazy.nvim` 会自动安装所有插件。

## :hammer_and_wrench: 安装与部署

### 步骤 1: 安装 Neovim (推荐源码编译)

```bash
# 1. 克隆 Neovim 仓库
git clone https://github.com/neovim/neovim /tmp/neovim 
cd /tmp/neovim 

# 2. 编译 Neovim (需要 cmake)
# 使用 RelWithDebInfo 模式，平衡性能与可调试性
make CMAKE_BUILD_TYPE=RelWithDebInfo 

# 3. 安装到系统
sudo make install
nvim --version
```

### 步骤 2: 安装 Rust/Cargo 及依赖工具

依赖于 Rust 生态系统中的高性能工具 `ripgrep`（极速搜索）和 `stylua`（Lua 格式化）。

```bash
# 1. 安装 Rust 工具链
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

# 2. 安装 cargo-binstall（使用预编译二进制文件快速安装）
cargo install cargo-binstall

# 3. 安装 ripgrep 和 stylua
cargo binstall ripgrep stylua

# 4. 安装 fzf
sudo dnf install -y fzf
```

> **网络提示**：如果遇到 `rustup.rs` 访问困难（如 n kb/s 速度），可以考虑使用 SSH 隧道进行代理，例如：
>
> - `ssh -D lport user@host`，动态转发/SOCKS 代理，`socks5://127.0.0.1:lport`
> - `ssh -L rport:lhost:lport user@host`，本地转发，将远程服务映射到本地端口
> - `ssh -R rport:lhost:lport user@host`，远程转发，将本地服务映射到远程端口

### 步骤 3: 设置系统别名和编辑器

设置了以下别名和环境变量，以便在命令行和 Git 等工具中默认使用 Neovim：

```bash
tee -a $HOME/.bashrc <<'EOF' 
alias vi='nvim'   # 将 "vi" 命令别名指向 "nvim"
alias vim='nvim'  # 将 "vim" 命令别名也指向 "nvim"

# 设置默认命令行编辑器，影响 git commit 等行为
export EDITOR=nvim
EOF
```

## :gear: 配置目录结构

主要逻辑集中在 `lua/config/` 目录下，方便管理：

| 文件/目录            | 作用     | 简要说明                                    |
| :------------------- | :------- | :------------------------------------------ |
| `config.options`     | 核心选项 | 修改 Neovim 的默认行为设置。                |
| `config.keymaps`     | 快捷键   | 自定义的快捷键映射。                        |
| `config.lazy`        | 插件管理 | `lazy.nvim` 的配置入口。                    |
| `config.lsp`         | LSP 配置 | Language Server Protocol (LSP) 的相关配置。 |
| `config.colorscheme` | 主题     | 主题配色方案配置。                          |

## :package: 集成插件列表 (plugins/)

| 插件文件               | 仓库/文档                                                    | 功能描述                                      |
| :--------------------- | :----------------------------------------------------------- | :-------------------------------------------- |
| `lazy.nvim`            | [lazy.folke.io](https://lazy.folke.io/)                      | 插件管理器。                                  |
| `LazyVim`              | [www.lazyvim.org](https://www.lazyvim.org/)                  | 基于 lazy.nvim 的基础集成。                   |
| `alpha.lua`            | [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)  | 自定义 Neovim 启动时的欢迎页。                |
| `autopairs.lua`        | [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) | 括号自动补全。                                |
| `blink.cmp.lua`        | [Saghen/blink.cmp](https://github.com/Saghen/blink.cmp)      | 代码补全引擎。                                |
| `bufferline.lua`       | [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | 顶部的 Buffer 标签栏。                        |
| `lualine.lua`          | [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 底部状态栏。                                  |
| `comment.lua`          | [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) | 快速注释/取消注释。                           |
| `telescope`            | [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 模糊查找界面。                                |
| `fzf-lua`              | [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua)      | 基于 fzf 的高性能模糊查找（需系统安装 fzf）。 |
| `gitsigns.lua`         | [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | 左侧 Git 状态显示。                           |
| `go.nvim.lua`          | [ray-x/go.nvim](https://github.com/ray-x/go.nvim)            | Go 语言开发环境集成。                         |
| `mason.lua`            | [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) | LSP 和依赖工具管理器。                        |
| `nvim-tree.lua`        | [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | 文件树/目录浏览。                             |
| `nvim-treesitter.lua`  | [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法树解析，提供高亮、折叠等。                |
| `todo-comments.lua`    | [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | `TODO`/`NOTE` 等标签高亮显示。                |
| `toggleterm.lua`       | [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | 浮动/下拉终端。                               |
| `tokyonight.theme.lua` | [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | 主题配置。                                    |
| `markdown.lua`         | [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Markdown 预览功能。                           |
| `whichkey.lua`         | [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | 快捷键查询提示。                              |
| `blame.lua`            | [FabijanZulj/blame.nvim](https://github.com/FabijanZulj/blame.nvim) | 查看文件修改历史。                            |
| `guess-indent.lua`     | [nmac427/guess-indent.nvim](https://github.com/nmac427/guess-indent.nvim) | 自动猜测缩进。                                |
| `rootdir.lua`          | [notjedi/nvim-rooter.lua](https://github.com/notjedi/nvim-rooter.lua) | 匹配项目根目录，方便范围检索。                |
| `conform.lua`          | [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | 代码格式化框架。                              |
| `indent-blankline`     | [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | 缩进线。                                      |
| `notify.lua`           | [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) | 优化 Neovim 通知体验。                        |
| `ai-coding.lua`        | [github/copilot.vim](https://github.com/github/copilot.vim)  | AI 编码助手 (暂未安装)。                      |

## :books: 额外的学习资源

  * **Lua 教程**：可以在 Neovim 中使用 `:h lua-guide` 查看官方 Lua 教程。
  * **Vim 迁移指南**：`:help nvim-from-vim` 提供了从 Vim 迁移到 Neovim 的指导。
  * ....
