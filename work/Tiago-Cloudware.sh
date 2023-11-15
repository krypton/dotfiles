#!/bin/zsh

export PATH="$PATH:/Applications/casper.app/Contents/MacOS/postgresql/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/redis/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/beanstalkd/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nb-xattr/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nginx-broker/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/nginx-epaper/bin"
export PATH="$PATH:/Applications/casper.app/Contents/MacOS/submit-job/bin"

export INSTALLATION_SCRIPTS_PATH="$HOME/work/installation-scripts"

export DEPLOY_MACHINE='CWBSTG'
export CONFZILLA_FEEDER="${HOME}/work/confzilla-cloudware"
export SHELLZILLA_PATH="$HOME/work/shellzilla"
source "$SHELLZILLA_PATH/helper.sh"

alias pdev="psql -Utoconline -dtoconline"
alias pcdb="psql -Utoconline -dcdb"
alias aurora="aurora -c ~/work/aurora.toml"
alias clogs='tail -f ~/Library/Logs/casper/*.log'

rrbundle() {
    cd ~/work/cloudware-business && \
    rbenv shell 2.1.5 && \
    sed -i '' '/gem '\''therubyracer'\''/s/^/#/' Gemfile && \
    bundle --jobs=`expr $(nproc --all) - 1`
}

aggregate_procfiles() {
  : > ~/work/Procfile.dev
  local folders=(
    "$HOME/work/cloudware-business/jobs/ruby3"
    "$HOME/work/cloudware-business/jobs/jruby"
    "$HOME/work/cloudware-central-db/jobs"
  )
  for dir in "${folders[@]}"; do
    echo $dir
    if [[ "$dir" == *"/jruby"* ]]; then
      cd $dir && rbenv shell jruby-9.3.10.0 && sdk use java 8.0.372-zulu && bundle && rbenv shell --unset
      continue
    fi
    if [[ "$dir" == *"/cloudware-central-db"* ]]; then
      cd $dir && cd ../ && bundle
    fi
    cd $dir && bundle
  done
  for dir in "${folders[@]}"; do
    if [ -f "$dir/Procfile" ]; then
      while IFS= read -r line; do
        local prefix="cd $dir &&"
        if [[ "$dir" == *"/jruby"* ]]; then
          prefix="eval \"\$(rbenv init - sh)\" && cd $dir && rbenv shell jruby-9.3.10.0 &&"
        fi

        if [[ "$line" == *"job"* ]]; then
          line="${line}"
        fi

        echo "${line/:/: $prefix}" >> ~/work/Procfile.dev
      done < "$dir/Procfile"
      echo -e "\n" >> ~/work/Procfile.dev
    fi
  done
  # add rails
  echo -e "rails: eval \"\$(rbenv init - sh)\" && source $USER_SHELLFILE && cd ~/work/cloudware-business && rbenv shell 2.1.5 && rrbundle && bundle exec rails s" >> ~/work/Procfile.dev
  # add aurora
  echo -e "aurora: cd ~/work && aurora" >> ~/work/Procfile.dev
}

start_dev_r3() {
    open /Applications/casper.app
    wait_for_postgres

    # If a session named development already exists, attach to it
    if tmux has-session -t "development" 2>/dev/null; then
        if [ -n "$TMUX" ]; then
            tmux switch-client -t "development"
        else
            tmux attach-session -t "development"
        fi
        return
    fi

    # Now, create a new session
    tmux new-session -d -s "development"

    tmux send-keys -t "development" "cd ~/work/cloudware-business && rbenv shell 2.1.5 && rrbundle && rails s" C-m

    tmux split-window -v -t "development"
    tmux send-keys -t "development" "cd ~/work/cloudware-business/jobs/ruby3 && rbenv shell 3.2.1 && bundle && overmind s" C-m

    tmux split-window -v -t "development"
    tmux send-keys -t "development" "cd ~/work/cloudware-business/jobs/jruby && sdk use java 8.0.372-zulu && rbenv shell jruby-9.3.10.0 && bundle --jobs=9 && overmind s" C-m

    tmux select-pane -t "development:1.4"
    tmux split-window -h -t "development"
    tmux send-keys -t "development" "cd ~/work/cloudware-central-db && rbenv shell 3.2.1 && bundle && overmind s -f jobs/Procfile" C-m

    if [ -n "$TMUX" ]; then
        tmux switch-client -t "development"
    else
        tmux attach-session -t "development"
    fi
}

start_dev() {
    open /Applications/casper.app
    wait_for_postgres

    # If a session named development already exists, attach to it
    if tmux has-session -t "development" 2>/dev/null; then
        if [ -n "$TMUX" ]; then
            tmux switch-client -t "development"
        else
            tmux attach-session -t "development"
        fi
        return
    fi

    # Now, create a new session
    tmux new-session -d -s "development"

    tmux send-keys -t "development" "cd ~/work/cloudware-business && rbenv shell 2.1.5 && rrbundle && rails s" C-m

    tmux split-window -v -t "development"
    tmux send-keys -t "development" "cd ~/work/cloudware-business/jobs/ruby3 && rbenv shell 3.2.1 && bundle && overmind s" C-m

    tmux split-window -v -t "development"
    tmux send-keys -t "development" "cd ~/work/cloudware-business/jobs/jruby && sdk use java 8.0.372-zulu && rbenv shell jruby-9.3.10.0 && bundle --jobs=9 && overmind s" C-m

    tmux select-pane -t "development:1.2"
    tmux split-window -h -t "development"
    tmux send-keys -t "development" "cd ~/work/cloudware-business/jobs/ruby2 && rbenv shell 2.7.6 && bundle && overmind s" C-m

    tmux select-pane -t "development:1.4"
    tmux split-window -h -t "development"
    tmux send-keys -t "development" "cd ~/work/cloudware-central-db && rbenv shell 3.2.1 && bundle && overmind s -f jobs/Procfile" C-m

    if [ -n "$TMUX" ]; then
        tmux switch-client -t "development"
    else
        tmux attach-session -t "development"
    fi
}

change_brand() {
  prompt brand "${YELLOW}Insert the brand name${RESTORE}"
  psql -U toconline -d cdb -c "UPDATE casper.users SET brand = '$brand'" \
  && psql -U toconline -d cdb -c "UPDATE casper.entities SET brand = '$brand'" \
  && psql -U toconline -d toconline -c "UPDATE public.users SET brand = '$brand'" \
  && psql -U toconline -d toconline -c "UPDATE public.companies SET brand = '$brand'"
}
