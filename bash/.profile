[ -f $HOME/.bashrc ] && . $HOME/.bashrc
# shell_helper options
export SHELL_HELPER_PATH="$HOME/work/shell-helper"
export USER_SHELLFILE="$SHELL_HELPER_PATH/users/Tiagos-MBP.sh"
source $USER_SHELLFILE

export PATH="$PATH:/Applications/casper.app/Contents/MacOS/postgresql/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/redis/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/beanstalkd/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nb-xattr/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nginx-broker/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nginx-epaper/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/submit-job/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"
alias ibrew="arch -x86_64 /usr/local/bin/brew"
