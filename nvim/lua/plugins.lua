return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

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

  -- icons for fzf and nvim-tree
  use 'kyazdani42/nvim-web-devicons'

  -- fzf
  use 'ibhagwan/fzf-lua'

  -- gruvbox
  use 'ellisonleao/gruvbox.nvim'

  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- web / svelte
  use { 'leafOfTree/vim-svelte-plugin' }
  use { 'leafgarland/typescript-vim' }
  use { 'cakebaker/scss-syntax.vim' }

  -- commenting
  use 'numToStr/Comment.nvim'

  -- tree-sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- debugger
  use { 'mfussenegger/nvim-dap' }

  -- nvim-dap golang config
  use { 'leoluz/nvim-dap-go' }
end)