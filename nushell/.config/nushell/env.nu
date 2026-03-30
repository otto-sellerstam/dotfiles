# ==========================================================================
# env.nu — loaded early, before config.nu
# Environment variables and PATH modifications go here.
# ==========================================================================

# Editor
$env.EDITOR = 'nvim'
$env.VISUAL = 'nvim'

# Node.js
$env.NODE_OPTIONS = '--max-old-space-size=12288'

# PATH additions
use std/util "path add"
path add "~/.local/bin"
path add ($env.HOME | path join ".cargo/bin")

# Mason (neovim LSP tools)
path add ($env.HOME | path join ".local/share/nvim/mason/bin")

# pnpm
let pnpm_home = ($env.HOME | path join ".local/share/pnpm")
if ($pnpm_home | path exists) {
  $env.PNPM_HOME = $pnpm_home
  path add $pnpm_home
}

# NVM / Node
let nvm_dir = ($env.HOME | path join ".nvm")
if ($nvm_dir | path exists) {
  $env.NVM_DIR = $nvm_dir
  # nvm doesn't support nushell natively — add the current default node to PATH
  let default_node = ($nvm_dir | path join "alias/default")
  if ($default_node | path exists) {
    let version = (open $default_node | str trim)
    let node_bin = ($nvm_dir | path join $"versions/node/($version)/bin")
    if ($node_bin | path exists) {
      path add $node_bin
    }
  }
}

