include () {
  [[ -f "$1" ]] && source "$1"
}

#
# prezto
#
include "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

#
# alias
#
include "${HOME}/.zsh/alias.sh"

#
# anyenv
#
include "${HOME}/.zsh/anyenv.sh"

#
# misc
#
include "${HOME}/.zsh/misc.sh"
