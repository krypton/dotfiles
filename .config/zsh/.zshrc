source "$XDG_CONFIG_HOME/zsh/aliases"

setopt AUTO_PARAM_SLASH
# Push the current working directory onto the directory stack
setopt AUTO_PUSHD
# Don't push multiple copies of the same directory onto the directory stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after pushd or popd
setopt PUSHD_SILENT

unsetopt CASE_GLOB

# Enable vi-like navigation on auto-completion menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# brew init
if [[ -s "/opt/homebrew/bin/brew" ]] && [ $OS = 'macos' ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Autocomplete hidden files
_comp_options+=(globdots)
source "$ZDOTDIR/external/completion.zsh"

# Load external completions
fpath=($ZDOTDIR/external $fpath)

# Load brew zsh completions
if type brew &>/dev/null; then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

autoload -Uz compinit && compinit

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/ohmyposh/zen.toml)"
fi

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
  autoload -Uz _overmind_generic && _overmind_generic
fi

# zsh-syntax-highlighting
source "$ZSH_PLUGINS_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# zsh-autosuggestions
source "$ZSH_PLUGINS_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"
# zsh-history-substring-search
source "$ZSH_PLUGINS_HOME/zsh-history-substring-search/zsh-history-substring-search.zsh"

# fzf completion
if [ $(command -v "fzf") ]; then
  source <(fzf --zsh)
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

# asdf init
if type brew &>/dev/null && [ -d "$(brew --prefix asdf)/libexec" ]; then
  source "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# 1password CLI completion
if [ $(command -v "op") ]; then
  eval "$(op completion zsh)"; compdef _op op
fi

# load zoxide as cd replacement
if [ $(command -v "zoxide") ]; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# load fzf-tab https://github.com/Aloxaf/fzf-tab
source "$ZDOTDIR/external/fzf-tab/fzf-tab.plugin.zsh"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
