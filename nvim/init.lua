require('plugins')

-- General configuration
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

vim.opt.scrolloff = 10
vim.opt.wrap = false

vim.wo.number = true
vim.wo.relativenumber = true

-- Autocmds
require('autocmd')

-- LSP
require('lsp')

-- Completion (nvim-cmp)
require('completion')

vim.o.termguicolors = true

-- sign_partial_hl = "WarningMsg",
-- require("gruvbox").setup({
--   overrides = {
--     WarningMsg = { link = "GruvboxOrangeBold" },
--   }
-- })
vim.cmd('colorscheme kanagawa')
vim.o.background = "dark"                  -- or "light" for light mode
vim.g.vim_svelte_plugin_use_typescript = 1 -- enables typescript syntax in .svelte files


-- Keymap
local function map(kind, lhs, rhs, opts)
  vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
end

local silentnoremap = { noremap = true, silent = true }

function _G.toggle_location_list()
  -- first argument is 0 for current window, it could be window id
  local winid = vim.fn.getloclist(0, { winid = 0 }).winid

  if winid == 0 then
    vim.cmd.lopen()
  else
    vim.cmd.lclose()
  end
end

-- fzf
map('n', '<space><space>', ':FzfLua<CR>', silentnoremap)
map('n', '<C-p>', ':FzfLua files<CR>', silentnoremap)
map('n', '<space>p', ':FzfLua files<CR>', silentnoremap)
map('n', '<space>b', ':FzfLua buffers<CR>', silentnoremap)

-- random remaps
map('i', 'jk', '<Esc>', silentnoremap)
map('n', '<leader>t', ':NvimTreeToggle<cr>', silentnoremap)
-- map('n', '<leader>c', ':ccl<cr> :lcl<cr>', silentnoremap)
map('n', '<leader>c', ':lua toggle_location_list()<cr>', silentnoremap)
map('n', '<leader>n', ':lnext<cr>', silentnoremap)
map('n', '<leader>N', ':lprev<cr>', silentnoremap)

-- new lsp remap location
map('v', '<space>ca', ':lua vim.lsp.buf.code_action()<CR>', silentnoremap)

local function vsnip_jump()
  if vim.fn['vsnip#available(1)'] then
    return '<Plug>(vsnip-expand-or-jump)'
  else
    return '<C-j>'
  end
end

local function vsnip_prev()
  if vim.fn['vsnip#jumpable(-1)'] then
    return '<Plug>(vsnip-jump-prev)'
  else
    return 'C-k'
  end
end

map('i', '<C-j>', vsnip_jump(), silentnoremap)
map('s', '<C-j>', vsnip_jump(), silentnoremap)
map('i', '<C-k>', vsnip_prev(), silentnoremap)
map('s', '<C-k>', vsnip_prev(), silentnoremap)

-- debugging mappings
map('n', '<F5>', ':DapContinue <CR>', silentnoremap)
map('n', '<F10>', ':DapStepOver <CR>', silentnoremap)
map('n', '<F11>', ':DapStepInto <CR>', silentnoremap)
map('n', '<F12>', ':DapStepOut <CR>', silentnoremap)
map('n', '<Leader>b', ':DapToggleBreakpoint <CR>', silentnoremap)
map('n', '<Leader>dr', ':DapToggleRepl <CR>', silentnoremap)
map('n', '<Leader>dl', ":lua require'dap'.run_last() <CR>", silentnoremap)

map('n', '<Leader>du', ":lua require'dapui'.toggle() <CR>", silentnoremap)
