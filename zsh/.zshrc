# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/postgresql/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/redis/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/beanstalkd/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nb-xattr/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nginx-broker/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nginx-epaper/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/submit-job/bin"
export PATH="/usr/local/bin/rubocop-daemon-wrapper:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export INSTALLATION_SCRIPTS_PATH="$HOME/work/installation-scripts"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="cloud"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-flow git-flow-avh git-prompt rbenv)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Set environment variable for homebrew access to GitHub
export HOMEBREW_GITHUB_API_TOKEN="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"

# Tell grep to highlight matches
export GREP_OPTIONS="--color=auto"

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

[[ -s "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"

# shell_helper options
export SHELLZILLA_PATH="$HOME/work/shellzilla"
export USER_SHELLFILE="$SHELLZILLA_PATH/users/Tiago-Cloudware.sh"
. $USER_SHELLFILE

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"
PROMPT='%{$fg_bold[cyan]%}$ZSH_THEME_CLOUD_PREFIX %{$fg_bold[green]%}%p %{$fg[green]%}%c %{$fg_bold[cyan]%}$(git_super_status)%{$fg_bold[blue]%} % %{$reset_color%}'
RPROMPT=''

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"source ~/.profile
eval "$(rbenv init - zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source ~/work/deployer/deployer.sh