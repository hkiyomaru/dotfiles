# ------------------------------------------
# ZI (https://z-shell.pages.dev/)
# ------------------------------------------
ZI="${HOME}/.zi"
source "${ZI}/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# ------------------------------------------
# Load zshrc components
# ------------------------------------------
ZSHRC="${HOME}/dotfiles/zsh/zshrc.d"

# Prezto
source "${ZSHRC}/prezto.zsh"

# Plugins
source "${ZSHRC}/plugin.zsh"

# Theme
source "${ZSHRC}/theme.zsh"

# Alias
source "${ZSHRC}/alias.zsh"

# Key binding
source "${ZSHRC}/keybinding.zsh"

# Misc.
source "${ZSHRC}/misc.zsh"
