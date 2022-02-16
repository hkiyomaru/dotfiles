export DOTFILES="$(dirname "$(dirname "$(readlink "${(%):-%N}")")")"

# LANG
export LANG=en_US.UTF-8
export LANGUAGE=en_US

# PATH
path=(
  {/usr{/local,},}/{bin,sbin}(N-/)
  ${path:#${HOME}/*}(N-/)
)
# MANPATH
manpath=(
  /usr{/local,}/share/man(N-/)
  ${manpath:#${HOME}/*}(N-/)
)
# INFOPATH
infopath=(
  /usr{/local,}/share/info(N-/)
  ${infopath:#${HOME}/*}(N-/)
)
# FPATH
fpath=(
  /usr{/local,}/share/zsh/{site-functions,vendor-completions}(N-/)
  ${fpath:#${HOME}/*}(N-/)
)
# PATH (SUDO)
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# CUDA
if [ -d /usr/local/cuda ]; then
  export CUDA_HOME=/usr/local/cuda
  export CUDA_PATH=/usr/local/cuda
  export PATH=/usr/local/bin:${CUDA_HOME}/bin:${path}
  export LD_LIBRARY_PATH=/usr/lib64:/usr/lib/x86_64-linux-gnu:/usr/local/lib64:$CUDA_HOME/lib64:$LD_LIBRARY_PATH
  export CUDA_DEVICE_ORDER=PCI_BUS_ID
fi

# Python
export PYTHONUSERBASE=${HOME}/.local

# Rust
if [ -d ${HOME}/.cargo/bin ]; then
  path=(${HOME}/.cargo/bin(N-) ${path})
fi

# Golang
export GOPATH=${HOME}/.go
path=(${GOPATH}/bin(N-) ${path})

# Perl5
export PERL5LIB="${HOME}/.perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="${HOME}/.perl5"
export PERL_MB_OPT="--install_base ${PERL_LOCAL_LIB_ROOT}"
export PERL_MM_OPT="INSTALL_BASE=${PERL_LOCAL_LIB_ROOT}"
path=(${PERL_LOCAL_LIB_ROOT}/bin(N-) ${path})

# Linuxbrew
if [ -d ${HOME}/.linuxbrew ]; then
  eval $(~/.linuxbrew/bin/brew shellenv)
fi

# Home
path=(
  ${HOME}{/.local,/local,/usr}/bin(N-/)
  ${path}
)
manpath=(
  ${HOME}{/.local,/local,/usr}/share/man(N-/)
  ${manpath}
)
infopath=(
  ${HOME}{/.local,/local,/usr}/share/info(N-/)
  ${infopath}
)
fpath=(
  ${HOME}/.zfunc(N-/)
  ${HOME}{/.local,/local,/usr}/share/zsh/{functions,site-functions}(N-/)
  ${fpath}
)

# When mac, avoid loading /etc/profile
case $(uname -s) in
  Darwin)
    setopt no_global_rcs
    ;;
esac
