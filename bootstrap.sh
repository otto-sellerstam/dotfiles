#!/usr/bin/env bash
# Install all tools that the dotfiles depend on, then stow configs.
# Usage: ./bootstrap.sh
#
# Safe to re-run — skips anything already installed.
# Supports Debian/Ubuntu (apt) and Arch Linux (pacman).

set -euo pipefail
cd "$(dirname "$0")"

# ==========================================================================
# Helpers
# ==========================================================================

info()  { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
ok()    { printf '\033[1;32m[ok]\033[0m    %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
fail()  { printf '\033[1;31m[fail]\033[0m  %s\n' "$*"; exit 1; }

has() { command -v "$1" &>/dev/null; }

is_wsl() { grep -qi microsoft /proc/version 2>/dev/null; }

# ==========================================================================
# 1. System packages
# ==========================================================================

APT_PACKAGES=(git stow curl build-essential direnv unzip
              fzf ripgrep fd-find bat jq)
PACMAN_PACKAGES=(git stow curl base-devel direnv unzip
                 fzf ripgrep fd bat jq
                 neovim nushell starship lazygit git-delta zoxide just)

if has pacman; then
  info "Installing system packages via pacman..."
  sudo pacman -Syu --noconfirm --needed "${PACMAN_PACKAGES[@]}"
  ok "System packages installed."
elif has apt-get; then
  info "Updating apt and installing system packages..."
  sudo apt-get update -qq
  sudo apt-get install -y -qq "${APT_PACKAGES[@]}"
  ok "System packages installed."
else
  warn "No supported package manager found — install these manually:"
  warn "  git, stow, curl, direnv, fzf, ripgrep, fd, bat, jq"
fi

# On Debian, fd and bat are installed under different names — symlink them
if has fdfind && ! has fd; then
  sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
  ok "Symlinked fdfind → fd."
fi
if has batcat && ! has bat; then
  sudo ln -sf "$(command -v batcat)" /usr/local/bin/bat
  ok "Symlinked batcat → bat."
fi

# ==========================================================================
# 2. Rust
# ==========================================================================

if has rustup; then
  ok "Rust already installed."
else
  info "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  # shellcheck disable=SC1091
  source "$HOME/.cargo/env"
  ok "Rust installed."
fi

# ==========================================================================
# 3. Neovim
# ==========================================================================

if has nvim; then
  ok "Neovim already installed."
else
  info "Installing Neovim..."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
  rm nvim-linux-x86_64.tar.gz
  ok "Neovim installed."
fi

# ==========================================================================
# 4. Nushell
# ==========================================================================

if has nu; then
  ok "Nushell already installed."
else
  has cargo || fail "cargo not found — cannot install Nushell."
  info "Installing Nushell via cargo..."
  cargo install nu
  ok "Nushell installed."
fi

# ==========================================================================
# 5. Starship prompt
# ==========================================================================

if has starship; then
  ok "Starship already installed."
else
  info "Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
  ok "Starship installed."
fi

# ==========================================================================
# 6. Python — uv
# ==========================================================================

if has uv; then
  ok "uv already installed."
else
  info "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
  ok "uv installed."
fi

# ==========================================================================
# 7. Node — NVM + pnpm
# ==========================================================================

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  ok "NVM already installed."
else
  info "Installing NVM..."
  NVM_LATEST=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_LATEST}/install.sh" | PROFILE=/dev/null bash
  ok "NVM ${NVM_LATEST} installed."
fi

# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

if ! has node; then
  info "Installing latest LTS Node..."
  nvm install --lts
  ok "Node LTS installed."
fi

if has pnpm; then
  ok "pnpm already installed."
else
  info "Installing pnpm..."
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  ok "pnpm installed."
fi

# ==========================================================================
# 8. GitHub CLI
# ==========================================================================

if has gh; then
  ok "GitHub CLI already installed."
elif has pacman; then
  sudo pacman -S --noconfirm --needed github-cli
  ok "GitHub CLI installed."
elif has apt-get; then
  info "Installing GitHub CLI..."
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt-get update -qq
  sudo apt-get install -y -qq gh
  ok "GitHub CLI installed."
else
  warn "Could not install GitHub CLI — install it manually."
fi

# ==========================================================================
# 9. CLI tools — lazygit, delta, zoxide, bat, just
# ==========================================================================

# --- lazygit ---
if has lazygit; then
  ok "lazygit already installed."
elif has pacman; then
  : # installed via pacman above
else
  info "Installing lazygit..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
  curl -sLo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar -xzf /tmp/lazygit.tar.gz -C /tmp lazygit
  sudo install /tmp/lazygit /usr/local/bin/lazygit
  rm /tmp/lazygit /tmp/lazygit.tar.gz
  ok "lazygit installed."
fi

# --- delta (git pager) ---
if has delta; then
  ok "delta already installed."
elif has pacman; then
  : # installed via pacman above
elif has cargo; then
  info "Installing delta via cargo..."
  cargo install git-delta
  ok "delta installed."
else
  warn "Could not install delta — install it manually."
fi

# --- zoxide (smart cd) ---
if has zoxide; then
  ok "zoxide already installed."
elif has pacman; then
  : # installed via pacman above
else
  info "Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  ok "zoxide installed."
fi

# --- just (task runner) ---
if has just; then
  ok "just already installed."
elif has pacman; then
  : # installed via pacman above
elif has cargo; then
  info "Installing just via cargo..."
  cargo install just
  ok "just installed."
else
  warn "Could not install just — install it manually."
fi

# ==========================================================================
# 10. WSL extras
# ==========================================================================

if is_wsl; then
  if has win32yank.exe; then
    ok "win32yank already on PATH."
  else
    info "Installing win32yank (WSL clipboard bridge)..."
    curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip
    unzip -oq /tmp/win32yank.zip -d /tmp/win32yank
    chmod +x /tmp/win32yank/win32yank.exe
    sudo mv /tmp/win32yank/win32yank.exe /usr/local/bin/
    rm -rf /tmp/win32yank /tmp/win32yank.zip
    ok "win32yank installed."
  fi
fi

# ==========================================================================
# 11. Stow configs
# ==========================================================================

info "Stowing dotfiles..."
./install.sh

echo
ok "Bootstrap complete! Open a new terminal to start in nushell."
