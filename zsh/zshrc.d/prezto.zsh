# ------------------------------------------
# Prezto
# ------------------------------------------
# Sets general shell options and defines environment variables.
zi snippet PZT::modules/environment

# Sets editor specific key bindings options and variables.
zi snippet PZT::modules/editor
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:editor' dot-expansion 'yes'

# Sets history options and defines history aliases.
HISTFILE="${HOME}/.zhistory"
HISTSIZE=200000
SAVEHIST=100000
zi snippet PZT::modules/history

# Sets directory options and defines directory aliases.
zi snippet PZT::modules/directory

# Provides for easier use of 256 colors and effects.
zi snippet PZT::modules/spectrum

# Provides for the interactive use of GNU utilities on BSD systems.
zi snippet PZT::modules/gnu-utility

# Defines general aliases and functions.
zi ice svn
zi snippet PZT::modules/utility

# Loads and configures TAB completion and provides additional completions from the zsh-completions project.
zi ice svn blockf atclone"git clone --recursive https://github.com/zsh-users/zsh-completions.git external"
zi snippet PZT::modules/completion

# Integrates zsh-syntax-highlighting into Prezto.
zi ice svn blockf atclone"git clone --recursive https://github.com/zsh-users/zsh-syntax-highlighting.git external"
zi snippet PZT::modules/syntax-highlighting
zstyle ':prezto:module:syntax-highlighting' highlighters \
  'main' \
  'brackets' \
  'pattern' \
  'line' \
  'cursor' \
  'root'

# Integrates zsh-autosuggestions into Prezto, which implements the Fish shell's autosuggestions feature
zi ice svn blockf atclone"git clone --recursive https://github.com/zsh-users/zsh-autosuggestions.git external"
zi snippet PZT::modules/autosuggestions

# Enhances the Git distributed version control system
zi ice svn
zi snippet PZT::modules/git

# Provides for an easier use of SSH by setting up ssh-agent.
zi snippet PZT::modules/ssh

# Provides functions to create, list, and extract archives.
zi ice svn as"null"
zi snippet PZT::modules/archive
