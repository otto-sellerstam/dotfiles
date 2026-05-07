# claude

Claude Code user-level config.

## Contents

- `.claude/settings.json` — defaults (auto permission mode, vim editor, skip permission prompts) plus a `UserPromptSubmit` hook that auto-renames sessions when invoking `/tackle-linear-issue PIT-XXX`.
- `.claude/hooks/rename-on-tackle-linear-issue.sh` — the hook script. Looks up the Linear issue title and emits `sessionTitle: "PIT-XXX: <title>"`. Falls back to just the issue ID if the Linear API is unreachable.

## Linear API key

The hook needs a personal Linear API key to resolve titles. Either:

- Export `LINEAR_API_KEY` in your shell, or
- Write the key (no whitespace) to `~/.config/linear/api_key` with `chmod 600`.

Generate one at <https://linear.app/settings/account/security>.

## Install

Stowed by `../install.sh` along with the rest of the dotfiles.
