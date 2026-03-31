#!/usr/bin/env bash
# Symlink all configs into $HOME using GNU Stow.
# Usage: ./install.sh
#
# If existing files conflict, --adopt pulls them into the repo and then
# git restore discards the differences, leaving the repo version in place.

set -euo pipefail
cd "$(dirname "$0")"

packages=(bash git nushell nvim starship yazi)

for pkg in "${packages[@]}"; do
  echo "Stowing $pkg..."
  stow -v --adopt --target="$HOME" "$pkg"
done

# --adopt overwrites repo files with the user's existing versions.
# Restore the repo's versions so the dotfiles are authoritative.
git checkout -- .

echo "Done."
