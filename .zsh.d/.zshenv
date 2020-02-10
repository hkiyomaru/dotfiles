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
# Python
#
export PYTHONUSERBASE=${HOME}/.local
if [ -f ${PYTHONUSERBASE}/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    source ${PYTHONUSERBASE}/bin/virtualenvwrapper.sh
fi

#
# Perl5
#
export PERL5LIB="${HOME}/.perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="${HOME}/.perl5"
export PERL_MB_OPT="--install_base ${PERL_LOCAL_LIB_ROOT}"
export PERL_MM_OPT="INSTALL_BASE=${PERL_LOCAL_LIB_ROOT}"
path=(${PERL_LOCAL_LIB_ROOT}/bin(N-) ${path})

#
# Go
#
export GOPATH=${HOME}/.go
path=(${GOPATH}/bin(N-) ${path})

#
# kurolab
#
if [ -d /mnt/berry/home ]; then
    source ${HOME}/dotfiles/.zsh.d/.kurolab/.zshenv
fi
