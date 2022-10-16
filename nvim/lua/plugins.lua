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


  ------------------------------- Visuals ---------------------------------

  -- icons for fzf and nvim-tree
  use 'kyazdani42/nvim-web-devicons'

  -- gruvbox
  use 'ellisonleao/gruvbox.nvim'


  ------------------------------- Naviation --------------------------------

  -- fzf
  use 'ibhagwan/fzf-lua'

  -- file tree
  use { 'kyazdani42/nvim-tree.lua', tag = 'nightly' }


  ---------------------------- Language Support ----------------------------

  -- go tooling
  use "olexsmir/gopher.nvim"

  -- web / svelte
  use 'leafOfTree/vim-svelte-plugin'
  use 'leafgarland/typescript-vim'
  use 'cakebaker/scss-syntax.vim'


  ----------------------------- Setup plugins -----------------------------

  -- nvim-tree
  require("nvim-tree").setup()

  -- Comment.nvim
  require('Comment').setup()

  -- Visuals
  require('gruvbox').setup()

  -- nvim-treesitter
  require('nvim-treesitter').setup()

  -- nvim-dap golang
  -- require('dap-go').setup()
  require('dap').adapters.go = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'dlv',
      args = { 'dap', '-l', '127.0.0.1:${port}' },
    }
  }

  -- nvim-autopairs
  require("nvim-autopairs").setup({})
end)
