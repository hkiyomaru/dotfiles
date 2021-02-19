#
# Executes commands at the start of an interactive session.
#

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#
# Alias
#
alias zr='exec zsh -l'
alias ssh='LC_PWD=$PWD ssh -o SendEnv=LC_PWD'
alias brew="env -u LD_LIBRARY_PATH PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:/usr/bin:/bin:/usr/sbin:/sbin brew"

#
# peco
#
peco-select-history() {
  BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
  CURSOR=${#BUFFER}
  zle reset-prompt
}
zle -N peco-select-history
bindkey '^R' peco-select-history

#
# anyenv
#
if [[ -d "${HOME}/.anyenv" ]]; then
  eval "$(anyenv init -)"
fi
