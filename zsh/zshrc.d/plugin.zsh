# ------------------------------------------
# Plugin
# ------------------------------------------
# Additional completion definitions for Zsh.
zinit ice wait lucid
zinit light zsh-users/zsh-completions

# Fish-like fast/unobtrusive autosuggestions for zsh.
zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# Fish shell-like syntax highlighting for Zsh.
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting
