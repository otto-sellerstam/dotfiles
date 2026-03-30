# ==========================================================================
# config.nu — main nushell configuration
# Loaded after env.nu on every interactive session.
# ==========================================================================

# --------------------------------------------------------------------------
# Shell behavior
# --------------------------------------------------------------------------

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"              # vi keybindings in the shell

$env.config.completions.case_sensitive = false
$env.config.completions.quick = true
$env.config.completions.partial = true
$env.config.completions.algorithm = "fuzzy"

$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 100_000
$env.config.history.isolation = false       # share history across sessions

# --------------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------------

# Git shortcuts
alias g = git
alias gs = git status
alias ga = git add
alias gc = git commit
alias gp = git push
alias gl = git log --oneline --graph -20
alias gd = git diff
alias gco = git checkout
alias gsw = git switch
alias gswc = git switch -c
alias gswm = git switch main

# Navigation
alias ll = ls -l
alias la = ls -la

# Quick access
alias nv = nvim
alias dots = cd ~/dotfiles
alias lg = lazygit
alias cat = bat

# Python / uv
alias uvr = uv run
alias uvs = uv sync

# --------------------------------------------------------------------------
# Custom commands
# --------------------------------------------------------------------------

# Quick directory creation and cd
def --env mkcd [dir: string] {
  mkdir $dir
  cd $dir
}

# Show top N largest files in current dir
def big [n: int = 10] {
  ls -la | where type == "file" | sort-by size -r | first $n
}

# Find files by name pattern
def ff [pattern: string] {
  glob $"**/*($pattern)*"
}

# --------------------------------------------------------------------------
# nvm wrapper (nvm is a bash function, not a binary)
# --------------------------------------------------------------------------

def --env nvm [...args: string] {
  let command = ($args | str join " ")
  # Run nvm in bash and capture the resulting PATH + NVM environment
  let result = (bash -c $"source ~/.nvm/nvm.sh && nvm ($command) && echo __NVM_ENV__ && echo $PATH && echo $NVM_DIR && echo $NVM_BIN" | str trim)

  if ($result | str contains "__NVM_ENV__") {
    let parts = ($result | split row "__NVM_ENV__" | last | lines | where { $in != "" })
    if ($parts | length) >= 1 {
      $env.PATH = ($parts.0 | split row ":")
    }
    if ($parts | length) >= 2 {
      $env.NVM_DIR = $parts.1
    }
    if ($parts | length) >= 3 {
      $env.NVM_BIN = $parts.2
    }
    # Show the nvm output (before the env marker)
    $result | split row "__NVM_ENV__" | first | str trim
  } else {
    # No env marker means nvm printed output without changing state (e.g. nvm list)
    $result
  }
}

# --------------------------------------------------------------------------
# Zoxide (smart cd)
# --------------------------------------------------------------------------

if (which zoxide | is-not-empty) {
  let zoxide_nu = ($nu.default-config-dir | path join "vendor/autoload/zoxide.nu")
  if not ($zoxide_nu | path exists) {
    mkdir ($nu.default-config-dir | path join "vendor/autoload")
    zoxide init nushell | save -f $zoxide_nu
  }
}

# --------------------------------------------------------------------------
# Starship prompt (if installed)
# --------------------------------------------------------------------------
# Starship provides a fast, customizable prompt that works across shells.
# Install: curl -sS https://starship.rs/install.sh | sh

if (which starship | is-not-empty) {
  let starship_nu = ($nu.default-config-dir | path join "vendor/autoload/starship.nu")
  if not ($starship_nu | path exists) {
    mkdir ($nu.default-config-dir | path join "vendor/autoload")
    starship init nu | save -f $starship_nu
  }
}

