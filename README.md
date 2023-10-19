# dotfiles

A collection of my personal and work related dotfiles.

## Installation

First step is to clone this repository:

    git clone git@github.com:krypton/dotfiles.git ~/.dotfiles

### Manual Installation

Create symbolic links for the configurations you want to use, e.g.:

    ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

### Using [GNU Stow](https://www.gnu.org/software/stow/) _(recommended)_

Install GNU Stow _(if not already installed)_

    Mac:      brew install stow
    Ubuntu:   apt-get install stow
    Fedora:   yum install stow
    Arch:     pacman -S stow

Then simply use stow to install the dotfiles you want to use:

    cd ~/.dotfiles
    stow vim
    stow tmux

### How to stow NVIM configuration

Simply stow into ~/.config folder, as follows:

    stow -t ~/.config nvim

### How to stow Yabai and skhd configurations

Simply stow into ~/.config folder, as follows:

    stow -t ~/.config yabai
    stow -t ~/.config skhd

### How to stow kitty configuration

Simply stow into ~/.config folder, as follows:

    stow -t ~/.config kitty

### How to stow bat configuration

Simply stow into ~/.config folder, as follows:

    stow -t ~/.config bat

## Acknowledgments

This dotfiles repo is inspired by the [Ham Vocke dotfile repo](https://github.com/hamvocke/dotfiles)
