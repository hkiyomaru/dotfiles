#!/bin/bash

set -xu

DOTDIR=$(cd "$(dirname "$0")"; pwd)
cd ${DOTDIR}

# add submodules
git submodule update --init --recursive

# prezto
ZDOTDIR=${DOTDIR%/}/.zsh.d

for f in ${ZDOTDIR%/}/.??*; do
    ln -snfv "$f" $HOME
done
