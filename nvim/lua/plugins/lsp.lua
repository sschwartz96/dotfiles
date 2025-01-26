local lua_setup = {
  filetypes = {
    "go",
    "svelte",
    "css",
    "html",
  },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        go = "html",
      },
      experimental = {
        classRegex = {
          { "Class(?:es)?[({]([^)}]*)[)}]", "[\"`]([^\"`]*)[\"`]" },
        },
      },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          indent_style = "space",
          indent_size = "2",
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- language server configuration
      lspconfig.lua_ls.setup({})
      lspconfig.gopls.setup({})
      lspconfig.tailwindcss.setup(lua_setup)
      lspconfig.svelte.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.html.setup({})
      lspconfig.cssls.setup({})
    end
  }
}
