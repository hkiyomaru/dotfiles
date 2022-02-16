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
zinit snippet PZT::modules/gnu-utility

# Defines general aliases and functions.
zinit ice svn
zinit snippet PZT::modules/utility

# Enhances the Git distributed version control system
zinit ice svn
zinit snippet PZT::modules/git

# Provides for an easier use of SSH by setting up ssh-agent.
zinit snippet PZT::modules/ssh

# Additional completion definitions for Zsh.
zinit ice wait lucid
zinit light zsh-users/zsh-completions

# Fish-like fast/unobtrusive autosuggestions for zsh.
zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# Fish shell-like syntax highlighting for Zsh.
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# Pretty, minimal and fast ZSH prompt
zinit ice lucid pick"/dev/null" multisrc"{async,pure}.zsh" nocd atload"!prompt_pure_precmd"
zinit light sindresorhus/pure
