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

$env.config.filesize.metric = true          # KB/MB/GB instead of KiB/MiB/GiB

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
# Starship prompt (if installed)
# --------------------------------------------------------------------------
# Starship provides a fast, customizable prompt that works across shells.
# Install: curl -sS https://starship.rs/install.sh | sh

if (which starship | is-not-empty) {
  mkdir ($nu.default-config-dir | path join "vendor/autoload")
  starship init nu | save -f ($nu.default-config-dir | path join "vendor/autoload/starship.nu")
}

