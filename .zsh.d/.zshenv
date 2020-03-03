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
  /usr/local/{bin,sbin}(N-/)
  /usr/{bin,sbin}(N-/)
  /{bin,sbin}(N-/)
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

export PYENV_ROOT=${HOME}/.pyenv
if [ -d ${PYENV_ROOT}/bin ]; then
    path=(${PYENV_ROOT}/bin(N-) ${path})
    eval "$(pyenv init -)"
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
export GOROOT=${HOME}/.go
path=(${GOROOT}/bin(N-) ${path})

#
# kurolab
#
if [ -d /mnt/berry/home ]; then
    source ${HOME}/dotfiles/.zsh.d/.kurolab/.zshenv
fi

#
# linuxbrew
#
if [ -d ${HOME}/.linuxbrew ]; then
    eval $(~/.linuxbrew/bin/brew shellenv)
fi

#
# Others
#
case $(uname -s) in
    Darwin)
        setopt no_global_rcs  # avoid loading /etc/profile
        ;;
esac
