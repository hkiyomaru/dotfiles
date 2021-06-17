#!/usr/bin/env bash
if ! [ -x "$(command -v brew)" ]; then
  case "${OSTYPE}" in
  linux*)
    git clone --depth 1 https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
    mkdir -p ~/.linuxbrew/bin
    ln -fs ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
    eval $(~/.linuxbrew/bin/brew shellenv)
    ;;
  darwin*)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ;;
  esac
fi

brew bundle --global --verbose
