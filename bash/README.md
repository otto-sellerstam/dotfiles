# Bash Config

Bash config kept as a fallback. Some system scripts, CI, and tools assume bash. Even with nushell as your interactive shell, `.bashrc` still matters.

## When bash runs

- System scripts that use `#!/bin/bash`
- SSH sessions where nushell isn't installed
- Subshells spawned by tools (make, docker, etc.)
- If you ever need to drop back: just type `bash`

## Customizing

Edit `~/.bashrc`. If you add Starship, include this at the end:

```bash
eval "$(starship init bash)"
```
