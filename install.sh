#!/bin/bash

set -xu

DOTDIR=$(cd "$(dirname "$0")"; pwd)
cd ${DOTDIR}

# update submodules
git submodule update --init --recursive

#
# zsh
#
ZDOTDIR=${DOTDIR%/}/.zsh.d
for f in ${ZDOTDIR%/}/.??*; do
    ln -snfv "$f" $HOME
done

#
# tmux
#
TMUXDORDIR=${DOTDIR%/}/.tmux.d
for f in ${TMUXDORDIR%/}/.??*; do
    ln -snfv "$f" $HOME
done
