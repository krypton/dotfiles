# dotfiles

Personal dotfiles with OS-based organization for Linux and macOS.

## Directory Structure

This repository uses an OS-based organization to keep configurations clean and separated:

```
.config/
├── common/      # Cross-platform configurations
│   ├── nvim/    # Neovim
│   ├── tmux/    # Terminal multiplexer
│   ├── zsh/     # Shell
│   ├── bat/     # Cat replacement
│   ├── btop/    # System monitor
│   ├── lazygit/ # Git TUI
│   └── ...
│
└── linux/       # Linux-only configurations
    ├── hypr/    # Hyprland window manager (Wayland)
    ├── waybar/  # Status bar
    ├── wofi/    # App launcher
    ├── mako/    # Notifications
    └── ...

.local/bin/
├── tmux-sessionizer     # Cross-platform scripts
├── tmux-cht.sh
├── install-neovim.sh
│
└── linux/              # Linux-only scripts
    ├── monitor.sh
    ├── wofi-launcher.sh
    └── screenshot.sh
```

## Installation using [GNU Stow](https://www.gnu.org/software/stow/)

### Prerequisites

Install GNU Stow:

```bash
Mac:      brew install stow
Ubuntu:   apt-get install stow
Fedora:   yum install stow
Arch:     pacman -S stow
```

### Quick Install

Use the provided installation script:

```bash
cd ~/personal/dotfiles
bash stow-install.sh
```

This script automatically:

- Detects your OS (Linux or macOS)
- Installs common cross-platform configs
- Installs OS-specific configs
- Sets up scripts in your PATH

### Manual Installation (Alternative)

If you prefer manual control:

```bash
cd ~/.config
stow -t . ../personal/dotfiles/.config/common
stow -t . ../personal/dotfiles/.config/linux    # Linux only
stow -t . ../personal/dotfiles/.config/macos    # macOS only
```

## What Gets Installed

### On macOS

- ✅ Cross-platform apps (Neovim, Tmux, Zsh, etc.)
- ✅ Cross-platform scripts
- ❌ Linux-specific configs and scripts (kept clean)

### On Linux

- ✅ All cross-platform configs and scripts
- ✅ All Linux-specific configs (Hyprland, Waybar, etc.)
- ✅ All Linux-specific scripts

## Post-Installation

### Symlink Migration

If you're updating from the old structure, see [SYMLINK_MIGRATION.md](SYMLINK_MIGRATION.md) for detailed migration instructions.

### First Time Setup

1. Review [INSTALL.md](INSTALL.md) for OS-specific dependencies
2. Run `bash stow-install.sh` from the dotfiles directory
3. Verify symlinks with `ls -la ~/.config/nvim` and `ls -la ~/.local/bin`

## Key Features

- **OS-aware**: Linux personal configs don't pollute macOS work setup
- **Cross-platform**: Share configs across systems where applicable
- **Modular**: Each application's config is independent
- **Version controlled**: All configurations tracked in git
- **Easily reproducible**: Single script to set up entire environment

## Contents

See [INSTALL.md](INSTALL.md) for comprehensive documentation on:

- System dependencies by OS
- Individual application configurations
- Custom scripts and their purposes

## Configuration Highlights

### Neovim

Modern Neovim configuration with lazy.nvim plugin manager. See `.config/common/nvim/README.md`

### Shell (Zsh)

Configured with:

- Oh My Posh prompt (zen theme with TokyoNight Moon colors)
- Comprehensive aliases and functions
- FZF integration for fuzzy finding
- Multiple terminal emulator support (Ghostty, Wezterm, Alacritty)

### Hyprland (Linux only)

Complete Wayland window manager setup with:

- Custom keybindings (vi-style navigation)
- Waybar status bar
- Mako notifications
- Hyprlock/Hypridle for security
- Wofi application launcher

### Tmux

Terminal multiplexer with:

- Vi-mode keybindings
- Custom functions (sessionizer, cheat sheet viewer)
- Integration with system tools

### Theming

All applications use **TokyoNight Moon** color scheme for consistency

## Tips

- Use `stow-install.sh` for automatic setup
- Check INSTALL.md for per-OS dependencies
- Scripts in `.local/bin/` are automatically in PATH
- See SYMLINK_MIGRATION.md if migrating from old structure
