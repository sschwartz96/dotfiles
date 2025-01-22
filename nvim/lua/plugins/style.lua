-- style plugins do not aid in the functionality of the editor
-- they contain nuanced benefits
return {

  -- colorschemes
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "rose-pine/neovim",
    lazy = true,
  },

  -- statusline
  -- TODO : look into https://github.com/bwpge/lualine-pretty-path
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("plugins.extra.lualine")
    end,
  },

  -- notifications & lsp progress
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  -- smooth scrolling
  {
    "karb94/neoscroll.nvim",
    opts = {
      hide_cursor = false,
      duration_multiplier = 0.7,
      -- cursor_scrolls_alone = true,
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
