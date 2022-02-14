# ------------------------------------------
# zinit
# ------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ------------------------------------------
# Load ZSHRCD components
# ------------------------------------------
ZSHRCD="${HOME}/dotfiles/zsh/zshrc.d"

# Prezto
source "${ZSHRCD}/prezto.zsh"

# Plugins
source "${ZSHRCD}/plugin.zsh"

# Theme
source "${ZSHRCD}/theme.zsh"

# Alias
source "${ZSHRCD}/alias.zsh"

# Key binding
source "${ZSHRCD}/keybinding.zsh"

# Misc.
source "${ZSHRCD}/misc.zsh"
