umask 0002 # Make everything group writable

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"

# export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/postgresql/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/redis/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/beanstalkd/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nb-xattr/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nginx-broker/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nginx-epaper/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/submit-job/bin"

export INSTALLATION_SCRIPTS_PATH="$HOME/work/installation-scripts"

# Set environment variable for homebrew access to GitHub
export HOMEBREW_GITHUB_API_TOKEN="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"

export CLICOLOR="1"
export LSCOLORS="ExFxCxDxBxegedabagacad"

# Tell grep to highlight matches
export GREP_OPTIONS="--color=auto"
export EDITOR="vim"

# Postgresql config
# export PGDATABASE="toconline"
# export PGPASSWORD=""

# Ansible config
export ANSIBLE_CONFIG="/usr/local/etc/ansible"

# Github repo tokens and invite or remove user examples
# cd casper-packager
# bash github-invite.sh -a add -u <user> -s github-defs/<account>.inc.sh
export CASPER2020_GITHUB_ACCESS_TOKEN="85fbbbb4298f5e1200b15a461df1a5697edd8051"
export INOCE1E_GITHUB_ACCESS_TOKEN="e442dcca74303cd0ed75fa472740198dba8833dc"
export VPFPINHO_GITHUB_ACCESS_TOKEN="5642e38e7683e452ea4af2352a78eb822364c055"
export CLOUDWARE_DEPLOY_GITHUB_ACCESS_TOKEN="5c2cf95cc6ff001763db29efba84ea4570b4773d"

export CR_PAT=1e3ade82ce3574288e145f2fed2d89e9bf06f032

test -e "$HOME/.iterm2_shell_integration.bash" && . "$HOME/.iterm2_shell_integration.bash"

# shell_helper options
export SHELL_HELPER_PATH="$HOME/work/shellzilla"
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

# Initialize bash-git-prompt
# https://github.com/magicmonty/bash-git-prompt
if [ -f /usr/local/share/gitprompt.sh ]; then
  # export GIT_PROMPT_THEME=Solarized_NoExitState
  export GIT_PROMPT_THEME="Single_line_Solarized"
  . /usr/local/share/gitprompt.sh
fi

eval "$(rbenv init -)"

# 1password CLI completion
source <(op completion bash)
