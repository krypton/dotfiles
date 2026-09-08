#!/usr/bin/env bash
set -e

REPO_DIR=~/personal/neovim

if [ ! -d "$REPO_DIR/.git" ]; then
  echo "🔻 Cloning neovim (master) to $REPO_DIR..."
  mkdir -p ~/personal
  git clone https://github.com/neovim/neovim "$REPO_DIR"
fi

cd "$REPO_DIR"
git pull
rm -rf build
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
