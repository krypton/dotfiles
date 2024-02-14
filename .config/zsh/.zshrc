source "$XDG_CONFIG_HOME/zsh/aliases"

setopt AUTO_PARAM_SLASH
# Push the current working directory onto the directory stack
setopt AUTO_PUSHD
# Don't push multiple copies of the same directory onto the directory stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after pushd or popd
setopt PUSHD_SILENT

unsetopt CASE_GLOB

# rose-pine-moon for linux tty
if [ "$TERM" = "linux" ]; then
	/bin/echo -e "
	\e]P0#232136
	\e]P1#eb6f92
	\e]P2#9ccfd8
	\e]P3#f6c177
	\e]P4#3e8fb0
	\e]P5#c4a7e7
	\e]P6#ea9a97
	\e]P7#e0def4
	\e]P8#393552
	\e]P9#eb6f92
	\e]PA#9ccfd8
	\e]PB#f6c177
	\e]PC#3e8fb0
	\e]PD#c4a7e7
	\e]PE#ea9a97
	\e]PF#e0def4
	"
	# get rid of artifacts
	clear
fi

# Enable vi-like navigation on auto-completion menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -U compinit; compinit

# Autocomplete hidden files
_comp_options+=(globdots)
source "$ZDOTDIR/external/completion.zsh"

# Load external completions
fpath=($ZDOTDIR/external $fpath)

autoload -Uz prompt_purification_setup; prompt_purification_setup

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape in vi mode
autoload -Uz cursor_mode && cursor_mode

# Edit command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Enable overmind completions
if [ $(command -v "overmind") ]; then
  source "$ZDOTDIR/external/zsh-overmind-autocomplete/zsh-overmind-autocomplete.plugin.zsh"
  autoload -Uz _overmind_generic, _overmind_generic
fi

# zsh-syntax-highlighting
source "$ZSH_PLUGINS_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# zsh-autosuggestions
source "$ZSH_PLUGINS_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"
# zsh-history-substring-search
source "$ZSH_PLUGINS_HOME/zsh-history-substring-search/zsh-history-substring-search.zsh"

# fzf completion
if [ $(command -v "fzf") ]; then
  [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh # fzf shell completion for Linux
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh # fzf key bindings for Linux
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # fzf shell completion for macOS
fi

# jumping directories
source "$ZDOTDIR/external/bd.zsh"

# load my custom scripts
source "$ZDOTDIR/scripts.zsh"

# bindkeys
bindkey -s "^F" "~/.local/bin/tmux-sessionizer\n"
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;5D" beginning-of-line
bindkey "^[[1;5C" end-of-line

# start i3wm
if [ "$(tty)" = "/dev/tty1" ] && [ $OS = "linux" ]; then
  pgrep i3 || exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi

# work related stuff
[[ -s $USER_SHELLFILE ]] && source $USER_SHELLFILE
[[ -s $DEPLOYER_SCRIPT ]] && source $DEPLOYER_SCRIPT
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# rbenv init
if [ $(command -v "rbenv") ]; then
  eval "$(rbenv init - zsh)"
fi

# 1password CLI completion
if [ $(command -v "op") ]; then
  eval "$(op completion zsh)"; compdef _op op
fi

# kitty shell integration
# this needs to be manually laoded to work with terminal multiplexers
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

# brew init
if [[ -s "/opt/homebrew/bin/brew" ]] && [ $OS = 'macos' ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
