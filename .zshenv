# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export LANG=C.UTF-8
unset LC_ALL

if [[ -d /model/kiyomaru ]]; then
  export XDG_CACHE_HOME=/model/kiyomaru/.cache
fi

# Keep paths placed ahead of the standard search paths (e.g. virtual environments)
# ahead of our tool setup, without giving system commands priority over Homebrew.
typeset -a _dotfiles_priority_path=()
for _dotfiles_path_entry in "${path[@]}"; do
  case "${_dotfiles_path_entry}" in
    /usr/local/bin|/usr/local/sbin|/usr/bin|/usr/sbin|/bin|/sbin) break ;;
  esac
  _dotfiles_priority_path+=("${_dotfiles_path_entry}")
done
unset _dotfiles_path_entry
typeset -U path
path=(
  "${path[@]}"
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

# Restore only the inherited priority prefix; all other inherited paths remain above.
path=("${_dotfiles_priority_path[@]}" "${path[@]}")
unset _dotfiles_priority_path
