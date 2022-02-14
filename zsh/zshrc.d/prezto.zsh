# ------------------------------------------
# Prezto
# ------------------------------------------
zstyle ':prezto:*:*' color 'yes'

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

# Enhances the Git distributed version control system
zi ice svn
zi snippet PZT::modules/git

# Provides for an easier use of SSH by setting up ssh-agent.
zi snippet PZT::modules/ssh
