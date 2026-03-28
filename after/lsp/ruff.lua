-- Ruff: Python linter + formatter (Astral)
-- Uses `uv run` so it auto-resolves the project's .venv
return {
  cmd = { 'uv', 'run', 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
}
