local lua_setup = {
  filetypes = {
    "go",
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

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.*",
        callback = function(args)
          -- check if buffer is attached to LSP
          -- TODO: ensure the LSP can format
          if next(vim.lsp.get_clients({ buf = args.buf })) == nil then
            print("buffer not attached to lsp so we won't format")
            return
          end

          -- organizeImports on save only *.go files
          if args.file:match(".go$") then
            print("organizeImports sent to lsp before format")
            local params   = vim.lsp.util.make_range_params(0, "utf-16")
            params.context = { only = { "source.organizeImports" } }
            local result   = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                  vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
              end
            end
          end
          vim.lsp.buf.format({ async = false })
        end
      })
    end
  }
}
