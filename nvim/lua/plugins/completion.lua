return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',
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
    keymap = {
      preset = "super-tab",
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
