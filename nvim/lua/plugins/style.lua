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
  },

  -- notifications & lsp progress
  -- {
  --   "j-hui/fidget.nvim",
  --   opts = {},
  -- },

  -- noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
          signature = {
            enabled = false,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end
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
