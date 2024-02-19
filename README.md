# dotfiles

## Installation

First step is to clone this repository:

    git clone git@github.com:krypton/dotfiles.git

### Using [GNU Stow](https://www.gnu.org/software/stow/)

Install GNU Stow _(if not already installed)_

    Mac:      brew install stow
    Ubuntu:   apt-get install stow
    Fedora:   yum install stow
    Arch:     pacman -S stow

Then simply use stow to install the dotfiles:

    stow -t ~ dotfiles
