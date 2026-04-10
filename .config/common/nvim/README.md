# Neovim Configuration

Modern Neovim config using vim.pack (Neovim built-in plugin manager).

## Requirements

- Neovim 0.12+
- ripgrep (`rg`) - grep searches
- fd (`fd`) - file search
- fzf (`fzf`) - fuzzy finder
- git
- tree-sitter CLI - parser installation
- Language-specific tools (see below)

## Installation

Symlink to this config and open Neovim:

```sh
ln -s ~/.dotfiles/.config/common/nvim ~/.config/nvim
nvim
```

Plugins auto-install on first launch. Press `a` to confirm all installations.

Install system dependencies (macOS):

```sh
brew install fzf fd ripgrep tree-sitter
```

## Plugins

### Completion

- [blink.cmp](https://github.com/saghen/blink.cmp) - Modern async completion with ghost text
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippet collection

### AI

- [opencode.nvim](https://github.com/NickvanDyke/opencode.nvim) - OpenCode AI assistant
- GitHub Copilot via native LSP (`copilot-language-server`, installed via Mason)

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

- [fzf-lua](https://github.com/ibhagwan/fzf-lua) - Fuzzy finder, grep, buffers (backed by fzf)
- [mini.nvim](https://github.com/echasnovski/mini.nvim) (mini.files) - File explorer
- [grapple.nvim](https://github.com/cbochs/grapple.nvim) - File tagging (opencode dependency)

### Git

- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git signs in gutter
- [neogit](https://github.com/NeogitOrg/neogit) - Magit-like Git interface
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) - Diff viewer

### UI

- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - Tokyo Night colorscheme
- [mini.nvim](https://github.com/echasnovski/mini.nvim) (mini.statusline, mini.notify, mini.indentscope, mini.ai, mini.icons, mini.files)
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding helper
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) - Code context display

### Productivity

- [obsidian.nvim](https://github.com/obsidian-nvim/obsidian.nvim) - Obsidian vault integration
- [vim-sleuth](https://github.com/tpope/vim-sleuth) - Auto-detect indentation
- [tmux.nvim](https://github.com/aserowy/tmux.nvim) - Tmux/Neovim integration

### Utility

- [mini.nvim](https://github.com/echasnovski/mini.nvim) - see UI section above for full module list
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
- staticcheck (Go)
- rubocop (Ruby via ruby_lsp)

## Keybindings

Leader key: `<Space>`

### General

- `<Space>pv` - File explorer (MiniFiles)
- `<Space>sf` - Find files (fzf-lua)
- `<Space>sg` - Find git files (fzf-lua)
- `<Space>ss` - Grep search (fzf-lua)
- `<Space>sb` - Find buffers (fzf-lua)
- `<Space>sh` - Search help (fzf-lua)
- `<Space>sc` - Grep word under cursor (fzf-lua)
- `<Space>sr` - Resume last search (fzf-lua)

### LSP

- `gd` - Go to definition
- `gD` - Go to declaration
- `<Space>rn` - Rename
- `K` - Hover documentation
- `<Space>qd` - Diagnostics in quickfix
- `<Space>qe` - Errors in quickfix
- `<Space>qD` - Buffer diagnostics in location list

### Git

- `<Space>gs` - Open Neogit

### AI

- `<Space>oa` - Ask OpenCode (normal/visual)
- `<Space>ot` - Toggle OpenCode
- `<Space>on` - New session
- `<Space>op` - Select prompt
- `<Space>oe` - Explain code near cursor

### Folds

- `<CR>` - Toggle fold

### Tmux

- `Ctrl-h/j/k/l` - Navigate windows (including tmux panes)
