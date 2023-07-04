return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -------------------------- General Tooling ------------------------------

  -- plenary.nvim
  use "nvim-lua/plenary.nvim"

  -- tree-sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Configurations for Nvim LSP
  use 'neovim/nvim-lspconfig'

  -- Completions
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- Snippets
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- commenting
  use 'numToStr/Comment.nvim'

  -- auto pairs
  use 'windwp/nvim-autopairs'

  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'leoluz/nvim-dap-go'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  -- surround
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  })

  -- git blame
  use 'f-person/git-blame.nvim'


  ------------------------------- Visuals ---------------------------------

  -- icons for fzf and nvim-tree
  use 'kyazdani42/nvim-web-devicons'

  -- gruvbox
  use 'ellisonleao/gruvbox.nvim'

  -- status line
  use 'nvim-lualine/lualine.nvim'

  -- smooth scrolling
  use 'karb94/neoscroll.nvim'

  -- function signature hint
  use 'ray-x/lsp_signature.nvim'


  ------------------------------- Navigation --------------------------------

  -- fzf
  use 'ibhagwan/fzf-lua'

  -- file tree
  use { 'kyazdani42/nvim-tree.lua', tag = 'nightly' }

  -- outline
  use { 'stevearc/aerial.nvim' }


  ---------------------------- Language Support ----------------------------

  -- go tooling
  use "olexsmir/gopher.nvim"

  -- web / svelte
  use 'leafOfTree/vim-svelte-plugin'
  use 'leafgarland/typescript-vim'
  use 'cakebaker/scss-syntax.vim'

  -- ledger
  use 'ledger/vim-ledger'

  -- dart
  use 'dart-lang/dart-vim-plugin'

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

  -- nvim-autopairs
  require("nvim-autopairs").setup({})

  -- aerial outline
  require('aerial').setup({
    on_attach = function(bufnr)
      -- Toggle the aerial window with <leader>a
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
      -- Jump forwards/backwards with '{' and '}'
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
      -- Jump up the tree with '[[' or ']]'
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
      vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
    end
  })

  -- surround
  require("nvim-surround").setup({})

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
end)
