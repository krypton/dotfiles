#!/bin/bash
set -e

OS=$(uname -s)
TARGET_DIR="${HOME}"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔗 Stow Installation for $OS"
echo "================================"

# Stow common configs
echo "📦 Stowing common configs..."
cd "$DOTFILES_DIR/.config"
stow -t "$TARGET_DIR/.config" common

# Stow OS-specific configs
case "$OS" in
  Darwin)
    echo "🍎 Stowing macOS-specific configs..."
    stow -t "$TARGET_DIR/.config" macos 2>/dev/null || echo "  (No macOS-specific configs yet)"
    ;;
  Linux)
    echo "🐧 Stowing Linux-specific configs..."
    stow -t "$TARGET_DIR/.config" linux
    ;;
  *)
    echo "❌ Unknown OS: $OS"
    exit 1
    ;;
esac

# Stow scripts from .local/bin (only the files, not subdirectories)
echo "🔧 Stowing scripts..."
cd "$DOTFILES_DIR"
# Stow only the cross-platform scripts by targeting individual files
for script in tmux-sessionizer tmux-cht.sh install-neovim.sh; do
  [ -f "$DOTFILES_DIR/.local/bin/$script" ] && \
    ln -sf "$DOTFILES_DIR/.local/bin/$script" "$TARGET_DIR/.local/bin/$script" 2>/dev/null || true
done

# Stow OS-specific scripts
case "$OS" in
  Linux)
    echo "🔧 Stowing Linux-specific scripts..."
    for script in monitor.sh wofi-launcher.sh screenshot.sh; do
      [ -f "$DOTFILES_DIR/.local/bin/linux/$script" ] && \
        ln -sf "$DOTFILES_DIR/.local/bin/linux/$script" "$TARGET_DIR/.local/bin/$script" 2>/dev/null || true
    done
    ;;
esac

echo "✅ Stow installation complete for $OS"
