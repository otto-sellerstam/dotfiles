# Git Config

Sensible defaults for daily git usage.

## What's configured

- **Rebase on pull** — `git pull` rebases instead of creating merge commits
- **Auto-track remote** — first `git push` auto-sets upstream
- **Histogram diffs** — better diff algorithm than the default
- **diff3 conflicts** — shows base + ours + theirs in merge conflicts
- **rerere** — remembers how you resolved conflicts, auto-applies next time
- **nvim as editor** — for commits, rebases, etc.

## Setup

Fill in your email in `.gitconfig`:

```
[user]
    email = your@email.com
```

## Cheat sheet

### Aliases (from .gitconfig)

```
git s              status -sb (short format)
git l              log --oneline --graph (last 20)
git la             log --oneline --graph --all (last 30)
git d              diff
git ds             diff --staged
git co             checkout
git br             branch
git unstage        reset HEAD --
git last           log -1 HEAD --stat
git amend          commit --amend --no-edit
```

### Daily workflow

```
git s                          # quick status
git add -p                     # stage interactively (hunk by hunk)
git commit -m "message"        # commit
git push                       # push (auto-tracks on first push)
git pull                       # pull with rebase
```

### Branching

```
git co -b feature-name         # create and switch to branch
git co main                    # switch to main
git br -d feature-name         # delete merged branch
git br -D feature-name         # force delete branch
```

### Undoing things

```
git unstage file.py            # unstage a file
git checkout -- file.py        # discard changes in working tree
git amend                      # add to last commit (same message)
git reset --soft HEAD~1        # undo last commit, keep changes staged
git reset --hard HEAD~1        # undo last commit, discard everything
git stash                      # shelve changes
git stash pop                  # restore shelved changes
```

### Inspecting

```
git l                          # recent history
git la                         # all branches
git last                       # details of last commit
git d                          # unstaged changes
git ds                         # staged changes
git log --oneline --author="Otto"   # your commits
git blame file.py              # who changed each line
```

### Rebasing

```
git pull                       # rebase by default (configured)
git rebase -i HEAD~3           # interactive rebase last 3 commits
git rebase --abort             # bail out
git rebase --continue          # after resolving conflicts
```
