# Bash Config

Bash is kept as a fallback shell. On interactive startup it auto-launches nushell if installed (via `exec nu`). If nushell isn't available, bash runs normally with full config.

## When bash runs

- As a fallback when nushell isn't installed
- System scripts that use `#!/bin/bash`
- SSH sessions where nushell isn't available
- Subshells spawned by tools (make, docker, etc.)
- If you need to drop back from nushell: just type `bash`

## What's configured

- **Auto-launch nushell** — `exec nu` at the top of interactive init
- **direnv hook** — auto-loads `.envrc` files
- **zoxide** — `z` for smart directory jumping
- **Starship prompt** — same prompt as nushell
- **Git aliases** — gco, gs, ga, gc, gd, gsw, gswc, gswm
- **NVM** — Node version management
- **PATH** — cargo, Mason (nvim LSP tools), ~/.local/bin

## Customizing

Edit `~/.bashrc`. The nushell launch guard uses `$NU_LAUNCHED` to prevent recursion.
