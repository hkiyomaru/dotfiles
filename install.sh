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

echo -e
success "Done."
