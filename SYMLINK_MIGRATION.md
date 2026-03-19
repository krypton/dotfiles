# Symlink Migration Guide

## Current Status
Your dotfiles have been reorganized into an OS-based structure:
- `.config/common/` - Cross-platform configurations
- `.config/linux/` - Linux-only configurations
- `.local/bin/` - Cross-platform scripts
- `.local/bin/linux/` - Linux-specific scripts

## Steps to Migrate Your Symlinks

### Step 1: Audit Current Symlinks
Check what symlinks currently exist:

```bash
ls -la ~/.config | grep "^\l"  # Symlinks in ~/.config
ls -la ~/.local/bin | grep "^\l"  # Symlinks in ~/.local/bin
```

### Step 2: Remove Old Symlinks
Remove all existing symlinks that will be recreated:

```bash
cd ~/.config
unlink alacritty
unlink bat
unlink btop
unlink ghostty
unlink lazygit
unlink nvim
unlink ohmyposh
unlink tmux
unlink wezterm
unlink zsh
unlink hypr
unlink waybar
unlink wofi
unlink mako
unlink swayosd
unlink zathura
unlink systemd
unlink uwsm
```

### Step 3: Run the New Installation Script

From the dotfiles directory:

```bash
cd ~/personal/dotfiles
bash stow-install.sh
```

This script will:
- Detect your OS automatically
- Stow all common configs
- Stow OS-specific configs (Linux or macOS)
- Create symlinks for cross-platform scripts in `.local/bin/`
- Create symlinks for OS-specific scripts (if applicable)

**Note:** The script directly creates symlinks for individual scripts rather than using `stow` for `.local/bin/`, to avoid duplicate or nested symlinks.

### Step 4: Verify New Symlinks

Check that symlinks now point to the new locations:

```bash
# Cross-platform app example
ls -la ~/.config/nvim
# Should show: ~/.config/nvim -> ../personal/dotfiles/.config/common/nvim

# Linux-specific app example (on Linux only)
ls -la ~/.config/hypr
# Should show: ~/.config/hypr -> ../personal/dotfiles/.config/linux/hypr

# Script example
ls -la ~/.local/bin/monitor.sh
# Should show: ~/.local/bin/monitor.sh -> ../personal/dotfiles/.local/bin/linux/monitor.sh
```

### Step 5: Verify Everything Works

Test that your applications still work:

```bash
# Test Neovim
nvim --version

# Test Tmux
tmux -V

# Test Zsh
zsh --version

# Test Hyprland (on Linux)
hyprctl version

# Test scripts
~/.local/bin/linux/monitor.sh --help
```

## What Changed

### Before
```
dotfiles/
├── .config/
│   ├── nvim/
│   ├── tmux/
│   ├── zsh/
│   ├── hypr/
│   ├── waybar/
│   └── ...
└── .local/bin/
    ├── tmux-sessionizer
    ├── tmux-cht.sh
    └── install-neovim.sh
```

### After
```
dotfiles/
├── .config/
│   ├── common/
│   │   ├── nvim/
│   │   ├── tmux/
│   │   ├── zsh/
│   │   └── ...
│   └── linux/
│       ├── hypr/
│       ├── waybar/
│       ├── wofi/
│       └── ...
└── .local/bin/
    ├── tmux-sessionizer
    ├── tmux-cht.sh
    ├── install-neovim.sh
    └── linux/
        ├── monitor.sh
        ├── wofi-launcher.sh
        └── screenshot.sh
```

## Installation Behavior

### On macOS
- ✅ Gets all cross-platform configs (`.config/common/`)
- ✅ Gets all cross-platform scripts (`.local/bin/`)
- ❌ Ignores Linux configs (`.config/linux/`)
- ❌ Ignores Linux scripts (`.local/bin/linux/`)
- **Result:** Clean work laptop with only relevant configs

### On Linux
- ✅ Gets all cross-platform configs (`.config/common/`)
- ✅ Gets all Linux configs (`.config/linux/`)
- ✅ Gets all cross-platform scripts (`.local/bin/`)
- ✅ Gets all Linux scripts (`.local/bin/linux/`)
- **Result:** Full feature set for personal laptop

## Troubleshooting

### Symlinks not created
- Ensure you removed old symlinks first
- Run `stow-install.sh` from the dotfiles directory
- Check that `.stow-local-ignore` is properly configured

### Path issues in scripts
- Scripts now live in `~/.local/bin/linux/` instead of `~/.config/hypr/scripts/`
- All references have been updated in `hyprland.conf`
- Make sure `~/.local/bin/linux/` is in your PATH (usually handled by `.zshenv`)

### Old symlinks still exist
```bash
# Force remove old symlinks
rm -f ~/.config/hypr ~/.config/waybar ~/.config/wofi etc.
```

## Future macOS Setup

If you set up these dotfiles on macOS in the future:

1. Create `~/.config/macos/` directory for macOS-specific configs
2. Run `stow-install.sh` - it will automatically pick up the macOS configs
3. No need to modify the script or ignore patterns
