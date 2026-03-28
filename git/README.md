# Git Config

Sensible defaults for daily git usage, with delta for syntax-highlighted diffs.

## What's configured

- **Rebase on pull** — `git pull` rebases instead of creating merge commits
- **Auto-track remote** — first `git push` auto-sets upstream
- **Histogram diffs** — better diff algorithm than the default
- **diff3 conflicts** — shows base + ours + theirs in merge conflicts
- **rerere** — remembers how you resolved conflicts, auto-applies next time
- **delta pager** — syntax-highlighted, side-by-side diffs with line numbers
- **nvim as editor** — for commits, rebases, etc.
- **GitHub CLI credentials** — `gh auth git-credential` for HTTPS auth

## Setup

Fill in your name and email in `.gitconfig`:

```
[user]
    name = Your Name
    email = your@email.com
```

Then authenticate with GitHub:

```bash
gh auth login
```

## Cheat sheet

Git aliases are defined in the shell configs (bash and nushell), not in `.gitconfig`.

### Daily workflow

```
git add -p                     # stage interactively (hunk by hunk)
git commit -m "message"        # commit
git push                       # push (auto-tracks on first push)
git pull                       # pull with rebase
lazygit                        # TUI git client (alias: lg)
```

### Branching

```
git switch -c feature-name     # create and switch to branch
git switch main                # switch to main
git branch -d feature-name     # delete merged branch
git branch -D feature-name     # force delete branch
```

### Undoing things

```
git reset HEAD -- file.py      # unstage a file
git checkout -- file.py        # discard changes in working tree
git commit --amend --no-edit   # add to last commit (same message)
git reset --soft HEAD~1        # undo last commit, keep changes staged
git reset --hard HEAD~1        # undo last commit, discard everything
git stash                      # shelve changes
git stash pop                  # restore shelved changes
```

### Inspecting

```
git log --oneline --graph -20        # recent history
git diff                             # unstaged changes (side-by-side via delta)
git diff --staged                    # staged changes
git log --oneline --author="Otto"    # your commits
git blame file.py                    # who changed each line
```

### Rebasing

```
git pull                       # rebase by default (configured)
git rebase -i HEAD~3           # interactive rebase last 3 commits
git rebase --abort             # bail out
git rebase --continue          # after resolving conflicts
```
