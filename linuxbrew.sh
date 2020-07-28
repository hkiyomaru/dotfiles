#!/usr/bin/env bash

#
# Install Linuxbrew in the home directory.
#
git clone --depth 1 https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
mkdir -p ~/.linuxbrew/bin
ln -fs ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)

#
# Update Linuxbrew.
#
brew update

#
# Upgrade installed formulae.
#
brew upgrade

#
# Install basic modules.
#
brew install gcc
brew install zsh

#
# Change the default shell.
#
BREW_PREFIX=$(brew --prefix)
chsh -s "${BREW_PREFIX}/bin/zsh"

#
# Install other modules.
#

# Editors.
brew install emacs
brew install vim

# Languages.
brew install python
brew install node
brew install go
brew install ruby
brew install perl

brew install pyenv
brew install pipenv
brew install poetry

# Databases.
brew install mysql
brew install mongodb

# Misc.
brew install tmux
brew install htop
brew install git
brew install wget
brew install curl

brew install nkf  # a yet another kanji code converter
brew install hub  # an extension to command-line git
brew install jq  # a command-line JSON processor
brew install peco  # an interactive filtering tool
brew install tree  # a recursive directory listing command
brew install pv  # monitor the progress of data through a pipe
brew install ripgrep  # a line-oriented search tool
brew install watch  # execute a program periodically, showing output in fullscreen
brew install graphviz  # a graph visualization software
brew install tokei  # display statistics about code
brew install st  # a simple terminal emulator
brew install procs  # a replacement for ps

#
# Uninstall old versions.
#
brew cleanup
