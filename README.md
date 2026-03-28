# Dotfiles

Personal configs managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick start (fresh machine)

```bash
git clone https://github.com/otto-sellerstam/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

Installs everything below and stows the configs. Safe to re-run. Supports Debian/Ubuntu (apt) and Arch Linux (pacman).

## What gets installed

| Category | Tools |
|---|---|
| Shell | nushell, bash (fallback), starship prompt |
| Editor | Neovim 0.11+ |
| Languages | Rust (rustup), uv (Python), NVM + Node LTS, pnpm |
| Git | git, gh (GitHub CLI), delta (diff pager), lazygit |
| Search | ripgrep, fd, fzf |
| CLI | zoxide, bat, jq, just, direnv |
| WSL | win32yank (clipboard bridge, auto-detected) |

## Configs only

If tools are already installed and you just want to symlink configs:

```bash
./install.sh
```

## Configs

- [bash](bash/README.md) — fallback shell, auto-launches nushell
- [git](git/README.md) — rebase-on-pull, delta pager, rerere
- [nushell](nushell/README.md) — primary shell with vi mode, fuzzy completions, zoxide
- [nvim](nvim/README.md) — Neovim 0.11+ with LSP, Telescope, and format-on-save
- [starship](starship/README.md) — minimal cross-shell prompt
