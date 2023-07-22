-- setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -------------------------- General Tooling ------------------------------

  -- plenary.nvim
  "nvim-lua/plenary.nvim",

  -- treesitter
  'nvim-treesitter/nvim-treesitter',

  -- neodev
  { "folke/neodev.nvim",        opts = {} },

  -- lsp
  "neovim/nvim-lspconfig",

  -- utilities
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },

  "ellisonleao/dotenv.nvim",

  -- completion
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',

  -- snippets
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',

  -- comment
  'numToStr/Comment.nvim',

  -- auto pairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  -- debugging
  'mfussenegger/nvim-dap',
  'leoluz/nvim-dap-go',
  'rcarriga/nvim-dap-ui',
  'theHamsta/nvim-dap-virtual-text',

  -- surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  -- git blame
  'f-person/git-blame.nvim',

  ------------------------------- Visuals ---------------------------------

  ---- color schemes ----

  -- gruvbox
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- icons for fzf and nvim-tree
  'kyazdani42/nvim-web-devicons',

  -- status line
  'nvim-lualine/lualine.nvim',

  -- smooth scrolling
  { 'karb94/neoscroll.nvim', event = "VeryLazy" },

  -- function signature hint
  'ray-x/lsp_signature.nvim',

  ------------------------------- Navigation --------------------------------

  -- fzf
  'ibhagwan/fzf-lua',

  -- file tree
  'kyazdani42/nvim-tree.lua',

  -- outline
  'stevearc/aerial.nvim',

  ---------------------------- Language Support ----------------------------

  -- go tooling
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    opts = {},
  },


  -- web / svelte
  'leafOfTree/vim-svelte-plugin',
  -- 'leafgarland/typescript-vim',
  -- 'cakebaker/scss-syntax.vim',

  -- ledger
  'ledger/vim-ledger',

  -- dart
  'dart-lang/dart-vim-plugin',


})

----------------------------- Setup plugins -----------------------------

-- nvim-tree
require("nvim-tree").setup()

-- Comment.nvim
require('Comment').setup()

-- Visuals
require('gruvbox').setup()

-- nvim-treesitter
require('nvim-treesitter').setup()

-- dap - debugging setup
require('dap-go').setup()
require('dap.ext.vscode').load_launchjs(nil, {})
require('dapui').setup()
require('nvim-dap-virtual-text').setup({})

-- aerial outline
require('aerial').setup({
  on_attach = function(bufnr)
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
    -- Jump forwards/backwards with '{' and '}'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
  end
})

-- git blame
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text

-- status line
require('lualine').setup({})
local git_blame = require('gitblame')

require('lualine').setup({
  sections = {
    lualine_c = {
      { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
    }
  }
})

-- neoscroll (smooth scrolling)
require("neoscroll").setup({
  hide_cursor = false,
})

-- vsnip location
vim.g.vsnip_snippet_dir = '/home/sam/dotfiles/nvim/.vsnip'

-- lsp signature
require("lsp_signature").setup()

-- dotenv
require('dotenv').setup({
  enable_on_load = true, -- will load your .env file upon loading a buffer
  verbose = false, -- show error notification if .env file is not found and if .env is loaded
})
