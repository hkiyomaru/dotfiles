# ------------------------------------------
# prezto
# ------------------------------------------
if [ -f "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ------------------------------------------
# alias
# ------------------------------------------

alias zr='exec zsh -l'

# When ssh, pass PWD for automatic cd
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

# ps -> procs
if [ -x "$(command -v procs)" ]; then
  alias ps='procs'
fi

# kurolab
if [ -d /mnt/berry/home ]; then
  alias brew="env -u LD_LIBRARY_PATH PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:/usr/bin:/bin:/usr/sbin:/sbin brew"
fi

# ------------------------------------------
# anyenv
# ------------------------------------------

if [ -d "${HOME}/.anyenv" ]; then
  eval "$(anyenv init -)"
fi

# ------------------------------------------
# misc
# ------------------------------------------

# NOTE: Refer to https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh.

if [ -x "$(command -v fzf)" ]; then
  __fzfcmd() {
    [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
      echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
  }

  # CTRL-T - Paste the selected file path(s) into the command line
  __fsel() {
    local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
      -o -type f -print \
      -o -type d -print \
      -o -type l -print 2> /dev/null | cut -b3-"}"
    setopt localoptions pipefail no_aliases 2> /dev/null
    local item
    eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
      echo -n "${(q)item} "
    done
    local ret=$?
    echo
    return $ret
  }

  fzf-file-widget() {
    LBUFFER="${LBUFFER}$(__fsel)"
    local ret=$?
    zle reset-prompt
    return $ret
  }
  zle     -N   fzf-file-widget
  bindkey '^T' fzf-file-widget

  # ALT-C - cd into the selected directory
  fzf-cd-widget() {
    local cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
      -o -type d -print 2> /dev/null | cut -b3-"}"
    setopt localoptions pipefail no_aliases 2> /dev/null
    local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-20%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
    if [[ -z "$dir" ]]; then
      zle redisplay
      return 0
    fi
    zle push-line # Clear buffer. Auto-restored on next prompt.
    BUFFER="cd ${(q)dir}"
    zle accept-line
    local ret=$?
    unset dir # ensure this doesn't end up appearing in prompt expansion
    zle reset-prompt
    return $ret
  }
  zle     -N    fzf-cd-widget
  bindkey '\ec' fzf-cd-widget

  # CTRL-R - Paste the selected command from history into the command line
  fzf-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
    selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
      FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
    local ret=$?
    if [ -n "$selected" ]; then
      num=$selected[1]
      if [ -n "$num" ]; then
        zle vi-fetch-history -n $num
      fi
    fi
    zle reset-prompt
    return $ret
  }
  zle     -N   fzf-history-widget
  bindkey '^R' fzf-history-widget
fi
