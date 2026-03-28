#!/usr/bin/env bash
# Symlink all configs into $HOME using GNU Stow.
# Usage: ./install.sh

set -euo pipefail
cd "$(dirname "$0")"

packages=(bash git nushell nvim starship)

for pkg in "${packages[@]}"; do
  echo "Stowing $pkg..."
  stow -v --target="$HOME" "$pkg"
done

echo "Done."
