# Nushell Config

Primary interactive shell with vi keybindings, fuzzy completion, zoxide, and Starship prompt.

Bash auto-launches nushell on interactive startup, so nushell is the default shell without needing `chsh`.

## Files

```
config.nu    Shell behavior, aliases, custom commands, zoxide + starship init
env.nu       Environment variables, PATH (cargo, Mason, NVM, pnpm)
```

## What's configured

- **Vi edit mode** — hjkl movement, ESC for normal mode, same muscle memory as nvim
- **Fuzzy completion** — type partial matches, Tab opens the menu
- **SQLite history** — shared across sessions, searchable
- **Starship prompt** — auto-initialized on first launch
- **Zoxide** — `z` for smart directory jumping, auto-initialized on first launch
- **Git aliases** — g, gs, ga, gc, gp, gl, gd, gco, gsw
- **Python/uv aliases** — uvr (uv run), uvs (uv sync)
- **Tool aliases** — lg (lazygit), cat (bat), nv (nvim), dots (cd ~/dotfiles)
- **Custom commands** — mkcd, big, ff
- **PATH** — cargo, Mason, NVM (default node version), pnpm

## Cheat sheet

### Nushell vs bash — key differences

```
# Everything is structured data, not text
ls                        # returns a table, not text
ls | where size > 1mb     # filter by column
ls | sort-by modified -r  # sort by column
ps | where cpu > 10       # processes using >10% CPU

# Pipelines work on tables
open data.json            # parses JSON into a table
open data.csv             # parses CSV into a table

# String interpolation uses $"..."
let name = "world"
echo $"hello ($name)"

# Variables are immutable by default
let x = 5
mut y = 10                # mutable
```

### Navigation

```
cd ~/projects             # same as bash
cd -                      # previous directory
z <partial>               # zoxide jump (learns your frequent dirs)
```

### History

```
Up / Down                 # scroll through history
Ctrl+r                    # search history
Right arrow               # accept ghost suggestion (grey text)
Tab                       # open completion menu
```

### Working with data

```
# Tables
ls | where type == "dir"
ls | select name size
ls | get name

# JSON
open file.json | get key.nested
'{"a":1}' | from json

# CSV
open data.csv | where column > 5

# Strings
"hello world" | str contains "world"   # true
"hello world" | split words             # [hello, world]
```

### Custom commands (from config.nu)

```
mkcd new-folder           # mkdir + cd in one
big 5                     # 5 largest files in current dir
ff "test"                 # find files matching *test*
```

### Aliases (from config.nu)

```
g, gs, ga, gc, gp         # git shortcuts
gl                         # git log --oneline --graph
gd, gco, gsw, gswc, gswm  # git diff, checkout, switch
ll / la                    # ls -l / ls -la
nv                         # nvim
lg                         # lazygit
cat                        # bat (syntax-highlighted cat)
dots                       # cd ~/dotfiles
uvr / uvs                  # uv run / uv sync
```

### Useful built-ins

```
which nvim                 # find executable
sys                        # system info table
$nu                        # nushell paths and info
help commands              # list all commands
help <command>             # help for a specific command
$env.PATH                  # view PATH as a list
```

### Running external commands

```
^bash -c "some bash command"   # ^ forces external execution
nu -c "ls | length"            # run nu command inline
```

### Important differences from bash

```
# No && or || — use ; or pipelines
cargo build; cargo test

# No export — use $env
$env.MY_VAR = "value"

# No if [ ... ] — use if (condition) { }
if (ls | length) > 0 { echo "not empty" }

# No for i in ... — use for $i in [...]
for $f in (ls).name { echo $f }
```
