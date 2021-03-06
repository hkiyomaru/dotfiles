# ------------------------------------------
# browser
# ------------------------------------------

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# ------------------------------------------
# editors
# ------------------------------------------

export EDITOR='emacs'
export VISUAL='emacs'
export PAGER='less'

# ------------------------------------------
# Language
# ------------------------------------------

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# ------------------------------------------
# path
# ------------------------------------------

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# ------------------------------------------
# less
# ------------------------------------------

export LESS='-i -M -R -S -w'
export LESSCHARSET='utf-8'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# automatic mv
# NOTE: For LC_PWD, refer to the alias definition in .zshrc.
#
if [[ -e "$LC_PWD" && "$(readlink -f $PWD)" != "$(readlink -f $LC_PWD)" ]]; then
  cd "$LC_PWD"
  unset LC_PWD
fi
