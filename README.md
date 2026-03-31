# hkiyomaru/dotfiles

Personal dotfiles for a Zsh-based development environment, primarily on macOS with Homebrew.

This repository manages:

- Zsh startup files: `.zshenv`, `.zprofile`, `.zshrc`
- XDG config files under `.config/`
- Homebrew packages and apps via `Brewfile`
- macOS defaults and shell setup through `install.sh`
- Zinit as a bundled Git submodule

## Quick start

Clone the repository and initialize submodules:

```sh
git clone --recurse-submodules https://github.com/hkiyomaru/dotfiles.git
cd dotfiles
```

If you already cloned it without submodules:

```sh
./update.sh
```

Run the full setup:

```sh
./install.sh all
```

## Install targets

The installer supports running each setup step independently:

```sh
./install.sh link
./install.sh brew
./install.sh shell
./install.sh macos
./install.sh all
```

### `link`

Creates symlinks for:

- `.zshenv`, `.zprofile`, `.zshrc` into `$HOME`
- files in `.config/` into `$HOME/.config`
- `.mackup.cfg` into `$HOME`
- bundled `zinit.git` into `${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git`

If `mackup` is installed, it also runs `mackup restore`.

### `brew`

- Installs Homebrew if needed
- Runs `brew bundle` using [`Brewfile`](./Brewfile)
- Installs `fzf` key bindings and shell completion

### `shell`

Configures `zsh` as the default login shell.

On macOS, this uses the Homebrew-installed `zsh`. On Linux, it prefers a system `zsh`.

### `macos`

Applies macOS preferences such as:

- faster keyboard repeat
- Dock auto-hide and layout tweaks
- Finder visibility preferences
- a few local symlinks under `~/.local/bin`

This step is skipped automatically on non-macOS systems.

## Update

To pull the latest changes and refresh submodules:

```sh
./update.sh
```

To update the repo and re-run the full setup:

```sh
./update.sh
./install.sh all
```

## Shell environment

The Zsh configuration is built around:

- `zinit` for plugin management
- Prezto snippets for environment, editor, history, directory, git, SSH, and completion
- `pure` prompt
- `zsh-autosuggestions`
- `fast-syntax-highlighting`

It also includes optional setup for tools such as `anyenv`, `chruby`, `pyenv`, Rust, Go, CUDA, and Linuxbrew/Homebrew when available.

## Repository layout

```text
.
├── .config/
│   ├── emacs/
│   └── git/
├── .zshenv
├── .zprofile
├── .zshrc
├── Brewfile
├── install.sh
├── update.sh
└── zinit.git/
```

## Notes

- The setup assumes a personal machine and may overwrite existing symlinks in your home directory.
- Some steps require `sudo`, especially `shell` and parts of `macos`.
- The installer currently supports macOS and Linux.
