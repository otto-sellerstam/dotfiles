# Neovim Config

Neovim 0.11+ config with native LSP, autocompletion, fuzzy finding, and format-on-save.

## Stack

| Language   | LSP Server       | Managed by        |
|------------|------------------|-----------------  |
| TypeScript | typescript-tools | Plugin            |
| Python     | pyrefly + ruff   | uv (project venv) |
| Rust       | rust-analyzer    | Mason             |
| Lua        | lua_ls           | Mason             |
| JS/TS lint | eslint           | Mason             |

## First-time setup

1. Launch `nvim` — plugins auto-install via lazy.nvim
2. `:Mason` → install: `lua-language-server`, `rust-analyzer`, `eslint-lsp`, `prettier`, `stylua`
3. Python projects need `pyrefly` and `ruff` in dev dependencies, then `uv sync`

## Files

```
init.lua              Main config (options, keymaps, plugins)
after/lsp/
  pyrefly.lua         Python type checker (uv run)
  ruff.lua            Python linter/formatter (uv run)
  lua_ls.lua          Lua language server
  rust_analyzer.lua   Rust language server (uses clippy)
  eslint.lua          JS/TS linter
lazy-lock.json        Plugin version lockfile
```

## Plugins

| Plugin | Purpose |
|---|---|
| catppuccin | Colorscheme (mocha) |
| which-key | Shows available keybinds on leader press |
| lualine | Statusline |
| gitsigns | Git gutter signs |
| fidget | LSP progress indicator |
| telescope + fzf-native | Fuzzy finder |
| oil | File explorer as a buffer |
| harpoon | Bookmark files for quick switching |
| nvim-surround | Add/change/delete surrounding pairs |
| vim-sleuth | Auto-detect indent settings |
| todo-comments | Highlight TODO/FIXME/etc |
| nvim-treesitter | Syntax grammar installation |
| mason | LSP server binary management |
| typescript-tools | TypeScript LSP (dedicated plugin) |
| nvim-cmp + LuaSnip | Autocompletion + snippets |
| conform | Format-on-save |

## Cheat sheet

### Basics

```
i                 Enter insert mode
<Esc>             Back to normal mode (also clears search highlight)
:w                Save (also auto-formats)
:q                Quit
:wq               Save and quit
u / Ctrl+r        Undo / redo
.                 Repeat last action
```

### Movement

```
h/j/k/l           Left / down / up / right
w / b              Next word / previous word
0 / $              Start / end of line
gg / G             Top / bottom of file
5j / 12k           Jump N lines
Ctrl+d / Ctrl+u    Half-page down / up
/text              Search, then n/N for next/prev
```

### Editing

```
dd                 Delete line
yy                 Yank (copy) line
p                  Paste below
ciw                Change inner word
ci"                Change inside quotes
diw                Delete inner word
cs"'               Change surrounding " to '
ds"                Delete surrounding "
ysiw"              Add " around word
```

### LSP

```
K                  Hover documentation
gd                 Go to definition
gr                 Go to references
gI                 Go to implementation
gD                 Go to declaration
<Space>rn          Rename symbol
<Space>ca          Code action
<Space>e           Show diagnostic float
<Space>q           Diagnostics to loclist
[d / ]d            Prev / next diagnostic
<Space>ds          Document symbols
<Space>ws          Workspace symbols
<Space>f           Format buffer
```

### Search (Telescope)

```
<Space>sf          Find files
<Space>sg          Grep across all files
<Space>sb          Search open buffers
<Space>s.          Recent files
<Space>/           Fuzzy search in current file
<Space>sd          Search diagnostics
<Space>sw          Search word under cursor
<Space>sr          Resume last search
```

### Files

```
-                  File explorer (Oil)
<Space>ha          Bookmark file (Harpoon)
<Space>hh          Harpoon menu
<Space>1-4         Jump to bookmarked file
```

### Splits

```
:vs                Vertical split
:sp                Horizontal split
Ctrl+h/j/k/l      Navigate splits
:q                 Close split
```

### Completion (insert mode)

```
Ctrl+n / Ctrl+p    Next / prev item
Ctrl+y             Accept
Ctrl+Space         Trigger manually
Tab / Shift+Tab    Snippet placeholders
Ctrl+d / Ctrl+f    Scroll docs up / down
```

### Useful commands

```
:checkhealth vim.lsp   LSP status
:LspLog                LSP error log
:Mason                 Manage LSP installs
:Lazy                  Manage plugins
:ConformInfo           Formatter status
```
