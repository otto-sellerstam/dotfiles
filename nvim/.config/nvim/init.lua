-- ==========================================================================
-- Otto's Neovim Config (Neovim 0.11+)
-- ==========================================================================
--
-- Structure:
--   ~/.config/nvim/
--     init.lua          ← this file
--     after/lsp/
--       pyrefly.lua     ← Python type checker (via uv run)
--       ruff.lua        ← Python linter/formatter (via uv run)
--       lua_ls.lua      ← Lua (for editing this config)
--       rust_analyzer.lua ← Rust
--       eslint.lua      ← JS/TS linting
--
-- LSP configs are in after/lsp/*.lua as tables. Neovim 0.11 auto-discovers them.
-- Python tools use `uv run` so they resolve each project's .venv automatically.
-- ==========================================================================

-- --------------------------------------------------------------------------
-- 1. OPTIONS
-- --------------------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus' -- WSL: needs win32yank.exe on PATH
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- --------------------------------------------------------------------------
-- 2. KEYMAPS
-- --------------------------------------------------------------------------

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left split' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right split' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower split' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper split' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })

-- --------------------------------------------------------------------------
-- 3. DIAGNOSTICS
-- --------------------------------------------------------------------------

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

-- --------------------------------------------------------------------------
-- 4. LSP KEYBINDS (on attach)
-- --------------------------------------------------------------------------
-- Neovim 0.11 sets defaults: grn=rename, gra=code_action, grr=references,
-- K=hover, gO=document_symbol, CTRL-S=signature_help.
-- We add Telescope-powered versions below.

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local ok, builtin = pcall(require, 'telescope.builtin')
    if ok then
      map('gd', builtin.lsp_definitions, 'Goto Definition')
      map('gr', builtin.lsp_references, 'Goto References')
      map('gI', builtin.lsp_implementations, 'Goto Implementation')
      map('<leader>ds', builtin.lsp_document_symbols, 'Document Symbols')
      map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
    else
      map('gd', vim.lsp.buf.definition, 'Goto Definition')
    end

    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    map('<leader>rn', vim.lsp.buf.rename, 'Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
  end,
})

-- --------------------------------------------------------------------------
-- 5. ENABLE LSP SERVERS
-- --------------------------------------------------------------------------
-- Configs live in lsp/*.lua (auto-discovered by Neovim 0.11).
-- We just tell Neovim which ones to activate.

vim.lsp.enable({
  'pyrefly',
  'ruff',
  'lua_ls',
  'rust_analyzer',
  'eslint',
})

-- --------------------------------------------------------------------------
-- 6. BOOTSTRAP LAZY.NVIM
-- --------------------------------------------------------------------------

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- --------------------------------------------------------------------------
-- 7. PLUGINS
-- --------------------------------------------------------------------------

require('lazy').setup({

  -- Colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({ flavour = 'mocha' })
      vim.cmd.colorscheme('catppuccin')
    end,
  },

  -- Which-key: shows available keybinds
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()
      require('which-key').add({
        { '<leader>s', group = '[S]earch' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>h', group = '[H]arpoon' },
      })
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- Git gutter signs
  { 'lewis6991/gitsigns.nvim', opts = {} },

  -- LSP progress indicator
  { 'j-hui/fidget.nvim',       opts = {} },

  -- Telescope: fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable('make') == 1 end,
      },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = { preview_width = 0.55 },
        },
      })
      pcall(require('telescope').load_extension, 'fzf')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch recent files' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch [W]ord' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 10, previewer = false,
        }))
      end, { desc = 'Fuzzy search in buffer' })
    end,
  },

  -- Oil: file explorer as a buffer
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup({ view_options = { show_hidden = true } })
      vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  -- Harpoon: bookmark files
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()
      vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon Add' })
      vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = 'Harpoon Menu' })
      for i = 1, 4 do
        vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon ' .. i })
      end
    end,
  },

  -- Editing
  { 'kylechui/nvim-surround',   event = 'VeryLazy', opts = {} },
  { 'tpope/vim-sleuth' },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },

  -- Treesitter (grammar installation — highlight/indent are native in 0.11)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = {
          'typescript', 'tsx', 'javascript',
          'python', 'rust', 'lua',
          'json', 'yaml', 'toml', 'markdown', 'markdown_inline',
          'html', 'css', 'bash', 'dockerfile',
          'gitcommit', 'diff',
        },
        auto_install = true,
      })
    end,
  },

  -- Mason: installs LSP server binaries
  -- After first launch, run :Mason and install:
  --   lua-language-server, rust-analyzer, eslint-lsp, prettier, stylua
  { 'mason-org/mason.nvim', opts = {} },

  -- TypeScript (own plugin, bypasses the lsp/ directory)
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        separate_diagnostic_server = true,
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'all',
          includeCompletionsForModuleExports = true,
        },
      },
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
      })
    end,
  },

  -- Formatting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      { '<leader>f', function() require('conform').format({ async = true }) end, desc = 'Format buffer' },
    },
    opts = {
      formatters_by_ft = {
        python = { 'ruff_format' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        javascript = { 'prettier' },
        json = { 'prettier' },
        lua = { 'stylua' },
        rust = { 'rustfmt' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    },
  },

}, {
  ui = { border = 'rounded' },
  checker = { enabled = false },
})
