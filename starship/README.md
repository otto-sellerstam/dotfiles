# Starship Config

A fast, cross-shell prompt written in Rust. Works in nushell, bash, zsh, fish — same prompt everywhere.

## Install

```bash
curl -sS https://starship.rs/install.sh | sh
```

Nushell auto-initializes it (configured in `config.nu`). For bash, add to `.bashrc`:

```bash
eval "$(starship init bash)"
```

## What's shown

```
~/dev/one-ring main +2 ~1 py 3.12 (.venv) rs 1.78 ›
│              │    │      │                │       └─ prompt (green=ok, red=error)
│              │    │      │                └─ rust version (if Cargo.toml present)
│              │    │      └─ python version + venv (if pyproject.toml present)
│              │    └─ git status (staged, modified)
│              └─ git branch
└─ directory (truncated to 3 levels)
```

In vi mode, the prompt character changes: `›` (insert) → `‹` (normal).

## What's hidden

Cloud provider indicators (AWS, GCP), Docker context, and package version are disabled to keep it clean.

## Customizing

Edit `~/.config/starship.toml`. Changes apply on next prompt render (no restart needed). Full docs at https://starship.rs/config/
