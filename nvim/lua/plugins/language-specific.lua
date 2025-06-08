return {
  -- markdown
  -- TODO
  -- flutter
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {
      lsp = {
        settings = {
          completeFunctionCalls = false,
        },
      },
    },
  },
}
