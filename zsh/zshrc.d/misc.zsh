# ------------------------------------------
# Misc
# ------------------------------------------
# fzf
[ -f "${HOME}/.fzf.zsh" ] && source $HOME/.fzf.zsh

# anyenv
[ -d "${HOME}/.anyenv" ] && eval "$(anyenv init -)"

# iterm2
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
[ -f "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"
