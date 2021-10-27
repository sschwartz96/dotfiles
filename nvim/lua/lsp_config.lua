---- signature config
--cfg = {
--  debug = false, -- set to true to enable debug logging
--  log_path = "debug_log_file_path", -- debug log path
--  verbose = false, -- show debug line number
--
--  bind = true, -- This is mandatory, otherwise border config won't get registered.
--  -- If you want to hook lspsaga or other signature handler, pls set to false
--  doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
--  -- set to 0 if you DO NOT want any API comments be shown
--  -- This setting only take effect in insert mode, it does not affect signature help in normal
--  -- mode, 10 by default
--
--  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
--
--  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
--  -- will set to true when fully tested, set to false will use whichever side has more space
--    -- this setting will be helpful if you do not want the PUM and floating win overlap
--  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
--  hint_enable = false, -- virtual hint enable
--  hint_prefix = "🐼 ",  -- Panda for parameter
--  hint_scheme = "String",
--  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
--  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
--  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
--  -- to view the hiding contents
--  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
--  handler_opts = {
--    border = "shadow"   -- double, single, shadow, none
--  },
--
--  always_trigger = true, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
--
--  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
--  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
--  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
--
--  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
--
--  transpancy = 0, -- disabled by default, allow floating win transparent value 1~100
--  shadow_blend = 36, -- if you using shadow as border use this set the opacity
--  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
--  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
--  toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
--}

-- recommended:
--require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key


vim.o.completeopt = 'menuone,noselect'

--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      -- For vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping.confirm({
      -- behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = {
    { name = 'nvim_lsp' },

    -- For vsnip user.
    { name = 'vsnip'},

    { name = 'buffer'},
  }
})

-- Setup lspconfig
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- function/method signature help
  require "lsp_signature".on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- eslint
nvim_lsp.eslint.setup { }

-- tailwindcss
nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- svelte
nvim_lsp.svelte.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- typescript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim"
  },
  -- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}

-- lua
nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = { "/home/sam/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/Linux/lua-language-server" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- gopls
nvim_lsp.gopls.setup {
  on_attach = on_attach,

  -- for postfix snippets and analyzers
  capabilities = capabilities,

  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      usePlaceholders = true,
      --experimentalPostfixCompletions = true,
    },
  },
}

-- helper functions
function GoImports(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *svelte,*.ts,*.js lua vim.lsp.buf.formatting()
augroup END
]], true)
