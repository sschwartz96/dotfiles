return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'rafamadriz/friendly-snippets',
    "Exafunction/windsurf.nvim",
  },
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- keymap = { preset = 'super-tab' },
    -- keymap = { preset = 'default' },
    -- completion.list.selection.preselect = function(ctx) return not require('blink.cmp').snippet_active({ direction = 1 }) end
    -- completion = {
    --   list = {
    --     selection = {
    --       preselect = function(ctx) return not require('blink.cmp').snippet_active({ direction = 1 }) end
    --     }
    --   }
    -- },
    completion = {
      menu = { auto_show = false },
      ghost_text = { enabled = true },
    },
    keymap = {
      preset = "super-tab",
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'omni', "codeium" },
      providers = {
        codeium = {
          name = 'Codeium',
          module = 'codeium.blink',
          async = true,
          score_offset = 1,
        },
      },
    },

    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
