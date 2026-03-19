# Installation Dependencies

## Installation

### Using stow-install.sh (Recommended)

```bash
cd ~/personal/dotfiles
bash stow-install.sh
```

The script handles OS detection and stows the appropriate configs automatically.

### Manual Installation

See README.md for manual installation instructions if preferred.

---

## Dependencies by Operating System

### Cross-Platform (All Systems)

These packages are needed on both macOS and Linux:

```
bat              # cat replacement with syntax highlighting
eza              # ls replacement (modern, colorful)
fd               # find replacement
fzf              # fuzzy finder
git              # version control
git-delta        # enhanced diff viewer
go               # Go programming language
jq               # JSON processor
lazygit          # Git TUI
neovim           # Text editor
node             # JavaScript runtime
postgresql       # Database (optional)
rbenv            # Ruby version manager
ripgrep          # grep replacement (rg)
stow             # dotfile manager
tldr             # man page alternative
tmux             # Terminal multiplexer
tree             # Directory tree viewer
xmlstarlet       # XML processor
yazi             # File manager
zoxide           # Directory jumper
zsh              # Shell (required)
zsh-autosuggestions      # Zsh plugin
zsh-history-substring-search  # Zsh plugin
zsh-syntax-highlighting        # Zsh plugin
```

### macOS Specific

Install via Homebrew:

```bash
brew install skhd yabai        # Window management
brew install 1password-cli      # Password manager
brew install alacritty          # Terminal emulator
brew install font-jetbrains-mono-nerd-font  # Font
brew install qtpass             # Password manager GUI
```

**Notes for macOS:**
- `skhd` and `yabai` are not configured in this dotfiles (Hyprland is Linux-only)
- Only install if you plan to use them separately
- macOS-specific configs can be added to `.config/macos/` when needed

### Linux Specific

Install via your package manager (examples for Arch):

```bash
# Wayland/Hyprland stack
sudo pacman -S hyprland          # Window manager
sudo pacman -S waybar            # Status bar
sudo pacman -S wofi              # Application launcher
sudo pacman -S mako              # Notification daemon
sudo pacman -S hypridle          # Idle manager
sudo pacman -S hyprlock          # Lock screen
sudo pacman -S hyprpaper         # Wallpaper manager
sudo pacman -S swayosd           # OSD for media keys
sudo pacman -S zathura           # PDF viewer

# Other
sudo pacman -S pass              # Password manager
sudo pacman -S uwsm              # Universal Wayland Session Manager
```

**For other Linux distributions:**
- Ubuntu/Debian: Use `apt`
- Fedora: Use `dnf`
- openSUSE: Use `zypper`

### Installation by Distribution

#### macOS (Homebrew)

```bash
# Core development tools
brew install bat eza fd fzf git git-delta go jq lazygit neovim node rbenv
brew install ripgrep stow tldr tmux tree xmlstarlet yazi zoxide zsh

# Zsh plugins
brew install zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

# Optional: macOS window management (not configured in dotfiles)
brew install skhd yabai

# Optional: macOS tools
brew install 1password-cli alacritty font-jetbrains-mono-nerd-font qtpass

# Optional: Development
brew install postgresql pass ncurses
```

#### Ubuntu/Debian

```bash
# Core development tools
sudo apt-get install bat eza fd-find fzf git git-delta golang-go jq lazygit neovim nodejs
sudo apt-get install ripgrep stow tldr tmux tree xmlstarlet yazi zoxide zsh

# Build tools (for some packages)
sudo apt-get install build-essential cmake pkg-config

# Optional: Development
sudo apt-get install postgresql postgresql-contrib pass

# Optional: Terminal emulator
sudo apt-get install alacritty
```

#### Arch Linux

```bash
# Core development tools
sudo pacman -S bat eza fd fzf git git-delta go jq lazygit neovim nodejs
sudo pacman -S ripgrep stow tldr tmux tree xmlstarlet yazi zoxide zsh

# Zsh plugins
sudo pacman -S zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

# Linux/Wayland specific
sudo pacman -S hyprland waybar wofi mako hypridle hyprlock hyprpaper swayosd zathura uwsm

# Optional: Development
sudo pacman -S postgresql pass

# Optional: Terminal emulator
sudo pacman -S alacritty
```

#### Fedora

```bash
# Core development tools
sudo dnf install bat fd-find fzf git git-delta golang jq lazygit neovim nodejs
sudo dnf install ripgrep stow tldr tmux tree xmlstarlet yazi zoxide zsh

# Zsh plugins
sudo dnf install zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

# Linux/Wayland specific
sudo dnf install hyprland waybar wofi mako hypridle hyprlock hyprpaper swayosd zathura

# Optional: Development
sudo dnf install postgresql postgresql-contrib pass

# Optional: Terminal emulator
sudo dnf install alacritty
```

---

## Post-Installation Setup

### 1. Set Zsh as Default Shell

```bash
chsh -s $(which zsh)
```

Then log out and log back in.

### 2. Install Ruby (via rbenv)

If you use Ruby:

```bash
rbenv init
rbenv install 3.0.0  # or desired version
rbenv global 3.0.0
```

### 3. Verify Installation

```bash
# Check that all key tools are installed
nvim --version
tmux -V
zsh --version
git --version
fzf --version
rg --version
bat --version
```

### 4. For Linux: Enable Systemd User Services

```bash
# If using rclone with Google Drive
systemctl --user enable --now rclone-gdrive.service
systemctl --user enable --now waybar.service
systemctl --user enable --now hypridle.service
```

---

## Troubleshooting

### Command not found errors
- Ensure `.local/bin/` is in your PATH (check `.zshenv`)
- Make sure scripts are executable: `chmod +x ~/.local/bin/*`

### Stow conflicts
- Remove old symlinks first (see SYMLINK_MIGRATION.md)
- Ensure `.stow-local-ignore` is properly configured

### Missing dependencies on Linux
- Update your package manager: `sudo pacman -Syu` (Arch) or `sudo apt update && sudo apt upgrade` (Debian)
- Some packages may have different names on different distributions

### macOS specific issues
- If Homebrew packages aren't found, run `brew update && brew upgrade`
- Check that Homebrew is properly installed: `brew doctor`

---

## Optional Enhancements

### Additional Tools (Optional)

```bash
# System monitoring
bat  # Already included - enhanced cat
btop # System monitor (included in .config/common/btop/)

# Fuzzy finding
fzf  # Already included

# Git enhanced
delta # Already included in git config

# Wayland specific (Linux)
grim # Screenshot tool
slurp # Area selector
wl-clipboard # Clipboard manager
```

### Language-Specific Tools

**Python:**
```bash
pip install black flake8 mypy  # Python tools
```

**Ruby:**
```bash
# Configured in .rubocop.yml
gem install rubocop
```

**Go:**
```bash
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

**JavaScript/Node:**
```bash
npm install -g prettier eslint typescript
```
