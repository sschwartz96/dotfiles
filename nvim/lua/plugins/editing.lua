return {

  -- pairs
  {
    'altermo/ultimate-autopair.nvim',
    lazy = true,
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recommended as each new version will have breaking changes
    opts = {},
  },

  -- surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },

  -- indentation
  {
    "tpope/vim-sleuth",
    lazy = true,
    event = "BufEnter",
  },

  -- formatting (not through LSP)
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        typescript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  }
}
