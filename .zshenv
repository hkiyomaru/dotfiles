# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# ------------------------------------------
# language
# ------------------------------------------

export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=${LANG}
export LC_ALL=${LANG}

# ------------------------------------------
# path
# ------------------------------------------

typeset -U path
path=(
  $HOME/local/bin(N-/)
  $HOME/usr/bin(N-/)
  /usr/local/{bin,sbin}(N-/)
  /usr/{bin,sbin}(N-/)
  /{bin,sbin}(N-/)
)

# CUDA
if [[ -d /usr/local/cuda ]]; then
  export CUDA_HOME="/usr/local/cuda"
  export CUDA_PATH="${CUDA_HOME}"
  export PATH="${CUDA_HOME}/bin:${PATH}"
  export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"
  export CUDA_DEVICE_ORDER="PCI_BUS_ID"
fi

# python
export PYTHONUSERBASE=${HOME}/.local
export WORKON_HOME=$HOME/.virtualenvs
export PYENV_ROOT=${HOME}/.pyenv
if [ -d ${PYENV_ROOT}/bin ]; then
  path=(${PYENV_ROOT}/bin(N-) ${path})
  eval "$(pyenv init -)"
fi

# rust
if [ -d ${HOME}/.cargo/bin ]; then
  path=(${HOME}/.cargo/bin(N-) ${path})
fi

# perl5
export PERL5LIB="${HOME}/.perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="${HOME}/.perl5"
export PERL_MB_OPT="--install_base ${PERL_LOCAL_LIB_ROOT}"
export PERL_MM_OPT="INSTALL_BASE=${PERL_LOCAL_LIB_ROOT}"
path=(${PERL_LOCAL_LIB_ROOT}/bin(N-) ${path})

# go
export GOPATH=$HOME/.go
path=(${GOPATH}/bin(N-) ${path})

# linuxbrew
for prefix in "${HOME}/.linuxbrew" "/usr/local" "/opt/homebrew"; do
  if [[ -x "${prefix}/bin/brew" ]]; then
    eval $("${prefix}/bin/brew" shellenv)
    break
  fi
done

# misc
path=($HOME/.local/bin(N-/) ${path})

# When mac, avoid loading /etc/profile
case $(uname -s) in
  Darwin)
    setopt no_global_rcs
    if [[ -e /Library/TeX ]]; then
      path=(/Library/TeX/texbin(N-/) ${path})
    fi
    ;;
esac
