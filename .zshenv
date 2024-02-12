# XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# The following are not part of the XDG Base Directory Specification
export XDG_BIN_HOME="$HOME/.local/bin"

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_DATA_HOME/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

# Dotfiles
export DOTFILES="$HOME/personal/.dotfiles"

# FZF theme tokyonight moon
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c8d3f5,bg:#222436,hl:#ff966c \
--color=fg+:#c8d3f5,bg+:#2f334d,hl+:#ff966c \
--color=info:#82aaff,prompt:#86e1fc,pointer:#86e1fc \
--color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d"

# Use ripgrep as the default source for fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Detect OS
case "$(uname -s)" in
  Darwin)
    export OS='macos'
    export ZSH_PLUGINS_HOME='/opt/homebrew/share'
    ;;
  Linux)
    export OS='linux'
    export ZSH_PLUGINS_HOME='/usr/share/zsh/plugins'
    ;;
  *)
    export OS='unknown'
    ;;
esac

# grep highlight
export GREP_OPTIONS='--color=auto'

export PATH="$XDG_BIN_HOME:$PATH"
export PATH="$XDG_DATA_HOME/nvim/mason/bin:$PATH"

# Homebrew into PATH
if [[ -d /opt/homebrew/bin ]] && [ $OS = 'macos' ]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# Load kitty into PATH
if [[ -d /Applications/kitty.app/Contents/MacOS ]] && [ $OS = 'macos' ]; then
  export PATH="/Applications/kitty.app/Contents/MacOS:$PATH"
fi

# Work related
if [ $OS = 'macos' ]; then
  export USER_SHELLFILE="$HOME/work/$HOST.sh"
  export DEPLOYER_SCRIPT="$HOME/work/deployer/deployer.sh"
  export SDKMAN_DIR="$HOME/.sdkman"

 # zsh-syntax-highlighting
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$ZSH_PLUGINS_HOME/zsh-syntax-highlighting/highlighters"
fi
