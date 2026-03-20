# Neovim Configuration

Modern Neovim config using lazy.nvim plugin manager.

## Requirements

- Neovim 0.10+ (optimized for 0.12)
- ripgrep (for grep searches)
- git
- Node.js (for Copilot)
- Language-specific tools (see below)

## Installation

Symlink to this config and open Neovim:

```sh
ln -s ~/.dotfiles/.config/common/nvim ~/.config/nvim
nvim
```

Plugins auto-install on first launch.

## Plugins

### Completion

- [blink.cmp](https://github.com/saghen/blink.cmp) - Modern async completion
- [blink-cmp-copilot](https://github.com/saghen/blink.cmp) - GitHub Copilot integration
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippet collection

### AI

- [copilot.lua](https://github.com/zbirenbaum/copilot.lua) - GitHub Copilot
- [opencode.nvim](https://github.com/opencodeai/opencode.nvim) - OpenCode AI assistant

### LSP & Diagnostics

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [mason.nvim](https://github.com/williamboman/mason.nvim) - Language server installer
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Mason + LSP bridge
- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) - Auto-install tools

### Formatting & Linting

- [conform.nvim](https://github.com/stevearc/conform.nvim) - Async formatting
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) - Async linting
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting & parsing

### File Navigation

- [snacks.nvim](https://github.com/folke/snacks.nvim) - File picker, grep, buffers
- [mini.nvim](https://github.com/echasnovski/mini.nvim) (mini.files) - File explorer
- [grapple.nvim](https://github.com/cbochs/grapple.nvim) - Tag files for quick access

### Git

- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git signs in gutter
- [neogit](https://github.com/NeogitOrg/neogit) - Magit-like Git interface
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) - Diff viewer

### UI

- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - Tokyo Night colorscheme
- [mini.nvim](https://github.com/echasnovski/mini.nvim) (mini.statusline, mini.notify, mini.indentscope)
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding helper
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) - Code context display

### Productivity

- [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) - Obsidian vault integration
- [vim-sleuth](https://github.com/tpope/vim-sleuth) - Auto-detect indentation
- [tmux.nvim](https://github.com/aserowy/tmux.nvim) - Tmux/Neovim integration

### Utility

- [mini.nvim](https://github.com/echasnovski/mini.nvim) (mini.ai, mini.icons, mini.files)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) - Context-aware comments

## Language Servers

- lua_ls (Neovim config)
- ruby_lsp (Ruby)
- ts_ls (TypeScript)
- gopls (Go)
- html, cssls, marksman, taplo

## Formatters

- prettier (JS/TS, JSON, YAML, HTML, CSS, Markdown)
- stylua (Lua)
- goimports, gofumpt (Go)

## Linters

- eslint_d (JS/TS)
- luacheck (Lua)
- staticcheck (Go)
- rubocop (Ruby via ruby_lsp)

## Keybindings

Leader key: `<Space>`

### General

- `<Space>pv` - File explorer (MiniFiles)
- `<Space>pf` - Find files (Snacks)
- `<Space>pg` - Find git files (Snacks)
- `<Space>ps` - Grep search (Snacks)
- `<Space>pb` - Find buffers (Snacks)

### LSP

- `gd` - Go to definition
- `gD` - Go to declaration
- `<Space>rn` - Rename
- `K` - Hover documentation
- `<Space>qd` - Diagnostics in quickfix
- `<Space>qD` - Buffer diagnostics

### Git

- `<Space>gs` - Open Neogit

### Folds

- `<CR>` - Toggle fold

### Tmux

- `Ctrl-h/j/k/l` - Navigate windows (including tmux panes)
