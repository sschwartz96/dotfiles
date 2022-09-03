require('plugins')

-- Setup plugins

-- nvim-tree
require("nvim-tree").setup()

-- Comment.nvim
require('Comment').setup()

-- Visuals
require('gruvbox').setup({})

-- nvim-treesitter
require('nvim-treesitter').setup()

-- nvim-dap golang
require('dap-go').setup()



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
vim.cmd('colorscheme gruvbox')
vim.o.background = "dark" -- or "light" for light mode
vim.g.vim_svelte_plugin_use_typescript = 1 -- enables typescript syntax in .svelte files


-- Keymap
local function map(kind, lhs, rhs, opts)
  vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
end

local silentnoremap = { noremap = true, silent = true }


-- fzf
map('n', '<space><space>', ':FzfLua<CR>', silentnoremap)
map('n', '<C-p>', ':FzfLua files<CR>', silentnoremap)
map('n', '<space>p', ':FzfLua files<CR>', silentnoremap)
map('n', '<space>b', ':FzfLua buffers<CR>', silentnoremap)

map('i', 'jk', '<Esc>', silentnoremap)
map('n', '<leader>t', ':NvimTreeToggle<cr>', silentnoremap)

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
