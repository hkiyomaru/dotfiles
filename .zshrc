# ------------------------------------------
# Plugin
# ------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Sets general shell options and defines environment variables.
zstyle ':prezto:*:*' color 'yes'
zinit snippet PZT::modules/environment

# Sets editor specific key bindings options and variables.
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:editor' dot-expansion 'yes'
zinit snippet PZT::modules/editor

# Sets history options and defines history aliases.
HISTFILE="${HOME}/.zhistory"
HISTSIZE=200000
SAVEHIST=100000
zinit snippet PZT::modules/history

# Sets directory options and defines directory aliases.
zinit snippet PZT::modules/directory

# Provides for easier use of 256 colors and effects.
zinit snippet PZT::modules/spectrum

# Provides for the interactive use of GNU utilities on BSD systems.
if [[ "$OSTYPE" == darwin* ]]; then
  zinit snippet PZT::modules/gnu-utility
fi

# Defines general aliases and functions.
zinit ice wait lucid  svn
zinit snippet PZT::modules/utility

# Enhances the Git distributed version control system
zinit ice wait lucid svn
zinit snippet PZT::modules/git

# Provides for an easier use of SSH by setting up ssh-agent.
zinit ice wait lucid
zinit snippet PZT::modules/ssh

# Additional completion definitions for Zsh.
zinit ice wait lucid
zinit snippet PZT::modules/completion

# Fish-like fast/unobtrusive autosuggestions for zsh.
zinit ice wait lucid atload'!_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Fish shell-like syntax highlighting for Zsh.
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# Pretty, minimal and fast ZSH prompt
zinit ice lucid pick"/dev/null" multisrc"{async,pure}.zsh" nocd atload"!prompt_pure_precmd"
zinit light sindresorhus/pure

# ------------------------------------------
# Misc
# ------------------------------------------
# fzf
[[ -f "${HOME}/.fzf.zsh" ]] && source $HOME/.fzf.zsh

# anyenv
[[ -x "$(command -v anyenv)" && -d "${HOME}/.anyenv" ]] && eval "$(anyenv init -)"

# chruby
if [[ -d "$(brew --prefix)/opt/chruby/share/chruby" ]]; then
  source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
  source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
  chruby ruby-3.1.3
fi

# ------------------------------------------
# Alias
# ------------------------------------------
alias zr='exec zsh -l'

# when ssh, pass PWD for automatic cd
alias ssh='LC_PWD=$PWD ssh -o SendEnv=LC_PWD'

# cat -> bat
if [[ -x "$(command -v bat)" ]]; then
  alias cat='bat'
fi

# ls -> exa
if [[ -x "$(command -v eza)" ]]; then
  alias l='eza'
  alias la='eza -a'
  alias ll='eza -la'
fi

# lab
if [[ -d /mnt/poppy/home ]]; then
  alias brew='env -u LD_LIBRARY_PATH PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:/usr/bin:/bin:/usr/sbin:/sbin brew'
fi
