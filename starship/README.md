# Starship Config

A fast, cross-shell prompt written in Rust. Works in nushell, bash, zsh, fish — same prompt everywhere.

Both nushell and bash auto-initialize starship (configured in `config.nu` and `.bashrc`).

## What's shown

```
~/dev/myproject main +2 ~1 py 3.12 (.venv) rs 1.78 node 20.11 ›
│               │    │     │                │       │            └─ prompt char
│               │    │     │                │       └─ node version
│               │    │     │                └─ rust version (if Cargo.toml)
│               │    │     └─ python version + venv (if pyproject.toml)
│               │    └─ git status (staged, modified)
│               └─ git branch
└─ directory (truncated to 3 levels)
```

The prompt character changes with vi mode: `›` (insert, green) / `‹` (normal, purple). Turns red on command error.

## What's hidden

Cloud provider indicators (AWS, GCP), Docker context, and package version are disabled to keep it clean.

## Customizing

Edit `~/.config/starship/starship.toml`. Changes apply on next prompt render (no restart needed).
