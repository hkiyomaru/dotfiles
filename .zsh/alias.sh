# reload zsh
alias zr='exec zsh -l'

# pass PWD when ssh for automatic cd
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
