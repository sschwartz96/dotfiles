--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- do not allow tsserver to format
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
end

local lspconfig = require('lspconfig')

-- Lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } }
    }
  },
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
})

-- Go
lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtmltmpl" },
  settings = {
    gopls = {
      -- analyses = {
      --   nilness = true,
      --   unusedparams = true,
      --   unusedwrite = true,
      --   useany = true,
      -- },
      -- experimentalPostfixCompletions = true,
      -- gofumpt = true,
      -- staticcheck = true,
      usePlaceholders = true,
      templateExtensions = { "gohtmltmpl", "gohtml" },
    },
  },
})

-- eslint
lspconfig.eslint.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- tailwindcss
lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- svelte
lspconfig.svelte.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- typescript
lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim"
  },
  settings = {
    -- TypeScript specific settings
    -- You can configure formatting options here
    format = {
      enable = true,         -- Enable formatting support
      tabSize = 2,           -- Set tab size to 2 spaces
      useTabs = false,       -- Use spaces instead of tabs
      singleQuote = true,    -- Use single quotes for strings
      trailingComma = "all", -- Add trailing commas
    }
  }
  -- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
})

-- dart
lspconfig.dartls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- rust
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  }
})

-- yaml
lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- c# (csharp) / .net (dotnet)
lspconfig.csharp_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- python - jeid
-- lspconfig.jedi_language_server.setup {
-- on_attach = on_attach,
-- capabilities = capabilities,
-- }
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "gohtmltmpl" },
})

-- ccls
lspconfig.ccls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- json
lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- htmx
lspconfig.htmx.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "gotmpl", "gohtmltmpl" },
})
