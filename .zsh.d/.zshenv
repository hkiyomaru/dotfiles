#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

#
# LANG
#
export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=${LANG}
export LC_ALL=${LANG}

#
# PATH
#
typeset -U path
path=(
  $HOME/.local/bin(N-/)
  $HOME/local/bin(N-/)
  $HOME/usr/bin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/bin(N-/)
  /usr/sbin(N-/)
  /bin(N-/)
  /sbin(N-/)
)

#
# go
#
if [[ -d ${HOME}/go ]]; then
    export GOPATH=${HOME}/.go
    path=(${GOPATH}/bin(N-) ${path})
fi
