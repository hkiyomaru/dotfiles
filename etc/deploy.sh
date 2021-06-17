#!/usr/bin/env bash

DOTPATH="$HOME/dotfiles"

# zsh
for f in "$DOTPATH"/{.zlogin,.zprofile,.zshenv,.zshrc,.zpreztorc}; do
    ln -sfnv "$f" "$HOME"
done

# homebrew
ln -snfv "$DOTPATH/.Brewfile" "$HOME"

# emacs
mkdir -p "$HOME/.emacs.d"
ln -snfv "$DOTPATH/.emacs.d/init.el" "$HOME/.emacs.d"
if [ -x "$(command -v emacs)" ]; then
    emacs --batch -f batch-byte-compile "$HOME/.emacs.d/init.el"
fi

# vim
ln -snfv "$DOTPATH/.vimrc" "$HOME"

# tmux
ln -snfv "$DOTPATH/.tmux.conf" "$HOME"

# others
mkdir -p "$HOME/.config"
for f in "$DOTPATH"/.config/*; do
    ln -snfv "$f" "$HOME/.config"
done

# bat
if [ -x "$(command -v bat)" ]; then
    bat cache --build
fi
