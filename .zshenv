# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=${LANG}
export LC_ALL=${LANG}

typeset -U path
path=(
  $HOME/local/bin(N-/)
  $HOME/usr/bin(N-/)
  /usr/local/{bin,sbin}(N-/)
  /usr/{bin,sbin}(N-/)
  /{bin,sbin}(N-/)
)

# {home,linux}brew
for prefix in "${HOME}/.linuxbrew" "/usr/local" "/opt/homebrew"; do
  if [[ -x "${prefix}/bin/brew" ]]; then
    eval $("${prefix}/bin/brew" shellenv)
    break
  fi
done

# Python
export PYTHONUSERBASE=${HOME}/.local

# Rust
path=(${HOME}/.cargo/bin(N-) ${path})

# Go
export GOPATH=$HOME/.go
path=(${GOPATH}/bin(N-) ${path})

# When mac, avoid loading /etc/profile
case $(uname -s) in
  Darwin)
    setopt no_global_rcs
    if [[ -e /Library/TeX ]]; then
      path=(/Library/TeX/texbin(N-/) ${path})
    fi
    ;;
esac

# CUDA
if [[ -d /usr/local/cuda ]]; then
  export CUDA_HOME="/usr/local/cuda"
  export CUDA_PATH="${CUDA_HOME}"
  export PATH="${CUDA_HOME}/bin:${PATH}"
  export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"
  export CUDA_DEVICE_ORDER="PCI_BUS_ID"
fi

# Local bin
path=($HOME/.local/bin(N-/) ${path})
