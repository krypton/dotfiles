umask 0002 # Make everything group writable

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"

# export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export LC_GIT_AUTHOR_NAME=$(git config --global user.name)
export LC_GIT_AUTHOR_EMAIL=$(git config --global user.email)

# Set environment variable for homebrew access to GitHub
export HOMEBREW_GITHUB_API_TOKEN="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"

export CLICOLOR="1"
export LSCOLORS="ExFxCxDxBxegedabagacad"

# Tell grep to highlight matches
export GREP_OPTIONS="--color=auto"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Postgresql config
# export PGDATABASE="toconline"
# export PGPASSWORD=""

# Ansible config
export ANSIBLE_CONFIG="/usr/local/etc/ansible"

test -e "$HOME/.iterm2_shell_integration.bash" && . "$HOME/.iterm2_shell_integration.bash"

# shell_helper options
export USER_SHELLFILE="$HOME/.dotfiles/work/Tiago-Cloudware.sh"
. $USER_SHELLFILE

# Add bash completions installed by homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Add git completions installed by homebrew
if [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
  . $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
fi

# Add git flow completions installed by homebrew
if [ -f "$(brew --prefix)/etc/bash_completion.d/git-flow-completion.bash" ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-flow-completion.bash
fi

# Add tmux completions installed by homebrew
if [ -f "$(brew --prefix)/etc/bash_completion.d/tmux" ]; then
  . $(brew --prefix)/etc/bash_completion.d/tmux
fi

# Add pass completions installed by homebrew
if [ -f "$(brew --prefix)/etc/bash_completion.d/pass" ]; then
  . $(brew --prefix)/etc/bash_completion.d/pass
fi

eval "$(rbenv init -)"

# 1password CLI completion
source <(op completion bash)

eval "$(/opt/homebrew/bin/brew shellenv)"
alias ibrew="arch -x86_64 /usr/local/bin/brew"