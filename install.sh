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
        info "Homebrew not installed. Installing."
        case "$(uname -s)" in
        Linux)
            git clone --depth 1 https://github.com/Homebrew/brew "${HOME}"/.linuxbrew/Homebrew
            mkdir -p "${HOME}"/.linuxbrew/bin
            ln -fs "${HOME}"/.linuxbrew/Homebrew/bin/brew "${HOME}"/.linuxbrew/bin
            eval $("${HOME}"/.linuxbrew/bin/brew shellenv)
            ;;
        Darwin)
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            ;;
        *)
            error "Only Linux and macOS are supported. Aborting."
            exit 1
            ;;
        esac
    fi

    brew bundle
}

setup_shell() {
    title "Configuring shell"

    if [[ "$(basename "${SHELL}")" != "zsh" ]]; then
        if ! [ -x "$(command -v brew)" ]; then
            case "$(uname -s)" in
            Linux)
                # Use zsh installed in the system
                zsh_path="$(command -v zsh)"
                for p in $(where zsh); do
                    if [[ -n ${p##$(realpath "${HOME}")/*} ]]; then
                        zsh_path="${p}"
                        break
                    fi
                done
                chsh -s "${zsh_path}"
                info "default shell changed to ${zsh_path}"
                ;;
            Darwin)
                # Use zsh installed by Homebrew
                [[ -n "$(command -v brew)" ]] && zsh_path="$(brew --prefix)/bin/zsh" || zsh_path="$(which zsh)"
                if ! [[grep "${zsh_path}" "/etc/shells"]]; then
                    info "Adding ${zsh_path} to /etc/shells"
                    echo "$zsh_path" | sudo tee -a /etc/shells
                fi
                chsh -s "${zsh_path}"
                info "default shell changed to ${zsh_path}"
                ;;
            *)
                error "Only Linux and macOS are supported. Aborting."
                exit 1
                ;;
            esac
        fi
    fi
}

case "$1" in
    link)
        setup_symlink
        ;;
    homebrew)
        setup_homebrew
        ;;
    shell)
        setup_shell
        ;;
    all)
        setup_symlink
        setup_homebrew
        setup_shell
        ;;
    *)
        echo -e $"\nUsage: $(basename "$0") {link|homebrew|shell|all}\n"
        exit 1
        ;;
esac

echo -e
success "Done."
