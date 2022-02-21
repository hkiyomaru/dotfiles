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
## Options
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt ALWAYS_TO_END        # Move cursor to the end of a completed word.
setopt PATH_DIRS            # Perform path search even on command names with slashes.
setopt AUTO_MENU            # Show completion menu on a successive tab press.
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB        # Needed for file modification glob modifiers with compinit.
unsetopt MENU_COMPLETE      # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL       # Disable start/stop characters in shell editor.
## Initialization
autoload -Uz compinit && compinit
## Case-insensitive, partial-word, and substring completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB
## Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
## Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
## Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
## Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true
## History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
## Environment Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
## Populate hostname completion. But allow ignoring custom entries from static
## */etc/hosts* which might be uninteresting.
zstyle -a ':prezto:module:completion:*:hosts' etc-host-ignores '_etc_host_ignores'
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'
## ... unless we really want to.
zstyle '*' single-ignored show
## Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'
## Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
## Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
## SSH/SCP/RSYNC
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
zinit ice wait lucid atinit"zicompinit; zicdreplay"
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

# ------------------------------------------
# Alias
# ------------------------------------------
alias zr='exec zsh -l'

# when ssh, pass PWD for automatic cd
alias ssh='LC_PWD=$PWD ssh -o SendEnv=LC_PWD'

# cat -> bat
if [ -x "$(command -v bat)" ]; then
  alias cat='bat'
fi

# ls -> exa
if [ -x "$(command -v exa)" ]; then
  alias l='exa'
  alias la='exa -a'
  alias ll='exa -la'
  alias ls='exa --color=auto'
fi

# p -> python3
alias p='python3'

# When kurolab, use Homebrew libraries
if [ -d /mnt/berry/home ]; then
  alias brew="env -u LD_LIBRARY_PATH PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:/usr/bin:/bin:/usr/sbin:/sbin brew"
fi

# ------------------------------------------
# Misc
# ------------------------------------------
# fzf
[ -f "${HOME}/.fzf.zsh" ] && source $HOME/.fzf.zsh

# anyenv
[ -d "${HOME}/.anyenv" ] && eval "$(anyenv init -)"
