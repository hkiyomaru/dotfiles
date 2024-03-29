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

    # zinit
    zinit_home="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    mkdir -p "$(dirname ${zinit_home})"
    ln -sfnv "${DOTFILES}/zinit.git" "${zinit_home}"

    # .zshenv, .zprofile, and .zshrc
    for path in ${DOTFILES}/{.zshenv,.zprofile,.zshrc}; do
        ln -sfnv ${path} ${HOME}
    done

    # .config
    mkdir -p ${HOME}/.config
    for path in ${DOTFILES}/.config/*; do
        ln -snfv ${path} ${HOME}/.config
    done

    # .mackup.cfg
    ln -sfnv ${DOTFILES}/.mackup.cfg ${HOME}
    [ -x "$(command -v mackup)" ] && mackup restore
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

    env -u LD_LIBRARY_PATH brew bundle

    info "Installing fzf"
    "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
}

setup_shell() {
    title "Configuring shell"

    if [[ "$(basename "${SHELL}")" != "zsh" ]]; then
        if [ -x "$(command -v brew)" ]; then
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

                info "Added ${zsh_path} to /etc/shells"
                echo "$zsh_path" | sudo tee -a /etc/shells
                
                chsh -s "${zsh_path}"
                info "default shell changed to ${zsh_path}"
                ;;
            Darwin)
                # Use zsh installed by Homebrew
                zsh_path="$(brew --prefix)/bin/zsh"

                echo "$zsh_path" | sudo tee -a /etc/shells
                info "Added ${zsh_path} to /etc/shells"
                
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

setup_macos() {
    title "Configuring macOS"

    if [[ "$(uname -s)" == "Darwin" ]]; then
        info "General: Disable the sound effect on boot"
        sudo nvram SystemAudioVolume=" "

        info "General: Show scrollbars"
        defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

        info "General: Enable subpixel font rendering on non-Apple LCDs"
        defaults write NSGlobalDomain AppleFontSmoothing -int 2

        info "General: Set a blazingly fast keyboard repeat rate"
        defaults write NSGlobalDomain KeyRepeat -int 1
        
        info "General: Set a shorter delay until key repeat"
        defaults write NSGlobalDomain InitialKeyRepeat -int 15

        info "Dock: Put the Dock on the left of the screen"
        defaults write com.apple.dock "orientation" -string "left"

        info "Dock: Make the icon size smaller"
        defaults write com.apple.dock "tilesize" -int "36"

        info "Dock: Hide automatically"
        defaults write com.apple.dock "autohide" -bool "true"

        info "Dock: Speed up showing and hiding"
        defaults write com.apple.dock autohide-delay -float 0
        defaults write com.apple.dock autohide-time-modifier -float 1.0

        info "Dock: Speed up moving apps across desktops"
        defaults write com.apple.dock workspaces-edge-delay -float 0.2

        info "Dock: Make the icon on the Dock to semi-transparent after hiding the app"
        defaults write com.apple.dock showhidden -bool true

        info "Mission Control: speed up animation"
        defaults write com.apple.dock expose-animation-duration -float 0.1

        info "Finder: Suppress creating .DS_Store in external storage"
        defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

        info "Finder: Disble animations"
        defaults write com.apple.finder DisableAllAnimations -boolean true

        info "Finder: Show all filename extensions"
        defaults write NSGlobalDomain AppleShowAllExtensions -bool true

        info "Finder: Show hidden files by default"
        defaults write com.apple.Finder AppleShowAllFiles -bool true

        info "Finder: Use current directory as default search scope"
        defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

        info "Finder: Show the path bar"
        defaults write com.apple.finder ShowPathbar -bool true

        info "Finder: Show the status bar"
        defaults write com.apple.finder ShowStatusBar -bool true

        info "Install Juman++"
        mkdir -p ${HOME}/.local/bin
        ln -sfnv ${DOTFILES}/.local/bin/jumanpp ${HOME}/.local/bin/jumanpp

        info "Install KNP"
        mkdir -p ${HOME}/.local/bin
        ln -sfnv ${DOTFILES}/.local/bin/knp ${HOME}/.local/bin/knp
    else
        warning "macOS not detected. Skipping."
    fi
}

case "$1" in
    link)
        setup_symlink
        ;;
    brew)
        setup_homebrew
        ;;
    shell)
        setup_shell
        ;;
    macos)
        setup_macos
        ;;
    all)
        setup_symlink
        setup_homebrew
        setup_shell
        setup_macos
        ;;
    *)
        echo -e $"\n${COLOR_GREEN}Usage: ${COLOR_CLEAR}$(basename "$0") {link|brew|shell|macos|all}\n"
        exit 1
        ;;
esac

echo -e
success "Done."
