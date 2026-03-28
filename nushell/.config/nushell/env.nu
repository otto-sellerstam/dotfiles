# ==========================================================================
# env.nu — loaded early, before config.nu
# Environment variables and PATH modifications go here.
# ==========================================================================

# Editor
$env.EDITOR = 'nvim'
$env.VISUAL = 'nvim'

# PATH additions
use std/util "path add"
path add "~/.local/bin"
path add ($env.HOME | path join ".cargo/bin")

# uv / Python
path add ($env.HOME | path join ".local/bin")  # uv installs here

# Mason (neovim LSP tools)
path add ($env.HOME | path join ".local/share/nvim/mason/bin")

