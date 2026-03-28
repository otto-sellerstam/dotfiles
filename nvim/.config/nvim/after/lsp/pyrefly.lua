-- Pyrefly: Python type checker (Meta)
-- Uses `uv run` so it auto-resolves the project's .venv
return {
  cmd = { 'uv', 'run', 'pyrefly', 'lsp' },
  filetypes = { 'python' },
  root_markers = { 'pyrefly.toml', 'pyproject.toml', 'setup.py', '.git' },
  settings = {
    python = {
      pyrefly = {
        -- Show type errors inline even without a pyrefly.toml
        displayTypeErrors = 'force-on',
      },
    },
  },
}
