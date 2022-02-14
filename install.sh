#!/usr/bin/env bash

DOTFILES="$(pwd)"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_CLEAR="\033[0m"

title() {
    echo -e "\n${COLOR_PURPLE}$1${COLOR_CLEAR}"
    echo -e "${COLOR_GRAY}==============================${COLOR_CLEAR}\n"
}

error() {
    echo -e "${COLOR_RED}Error: ${COLOR_CLEAR}$1"
    exit 1
}

warning() {
    echo -e "${COLOR_YELLOW}Warning: ${COLOR_CLEAR}$1"
}

info() {
    echo -e "${COLOR_BLUE}Info: ${COLOR_CLEAR}$1"
}

success() {
    echo -e "${COLOR_GREEN}$1${COLOR_CLEAR}"
}

setup_symlink() {
    title "Creating symlinks"

    # zsh
    for file in $DOTFILES/zsh/{.zlogin,.zprofile,.zshenv,.zshrc,.zpreztorc}; do
        ln -sfnv ${file} ${HOME}
    done

    # others
    mkdir -p ${HOME}/.config
    for file in ${DOTFILES}/.config/*; do
        ln -snfv ${file} ${HOME}/.config
    done
}

setup_homebrew() {
    title "Setting up Homebrew"
    if ! [ -x "$(command -v brew)" ]; then
        case "${OSTYPE}" in
        linux*)
            git clone --depth 1 https://github.com/Homebrew/brew "${HOME}"/.linuxbrew/Homebrew
            mkdir -p "${HOME}"/.linuxbrew/bin
            ln -fs "${HOME}"/.linuxbrew/Homebrew/bin/brew "${HOME}"/.linuxbrew/bin
            eval $("${HOME}"/.linuxbrew/bin/brew shellenv)
            ;;
        darwin*)
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            ;;
        esac
    fi
    brew bundle
}

case "$1" in
    link)
        setup_symlink
        ;;
    homebrew)
        setup_homebrew
        ;;
    all)
        setup_symlink
        setup_homebrew
        ;;
    *)
        echo -e $"\nUsage: $(basename "$0") {link,homebrew|all}\n"
        exit 1
        ;;
esac

echo -e
success "Done."
