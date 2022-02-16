# ------------------------------------------
# Prezto
# ------------------------------------------
zstyle ':prezto:*:*' color 'yes'

# Sets general shell options and defines environment variables.
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
