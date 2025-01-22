--
-- keymaps
--
vim.keymap.set("i", "jk", "<esc>")

-- neotree
vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle<cr>")

-- fzf
vim.keymap.set("n", "<leader>T", "<cmd>FzfLua tabs<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua grep<cr>")

-- yanking to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- lsp
--
-- remove existing neovim gr mapping
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")

vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<cr>")
vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>")
vim.keymap.set("v", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>")
vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
-- lsp end

-- quickfix
vim.keymap.set("n", "<M-j>", "<cmd>cnext<cr>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<cr>")
-- quickfix end

-- debug
vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")
vim.keymap.set("n", "<leader>5", "<cmd>DapContinue<cr>")


vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
-- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
-- vim.keymap.set('n', '<Leader>lp',
--   function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = "dap.repl.open" })
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = "dap.run_last" })
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function() require('dap.ui.widgets').hover() end,
  { desc = "dap.ui.widgets.hover" })
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function() require('dap.ui.widgets').preview() end,
  { desc = "dap.ui.widgets.preview" })
vim.keymap.set('n', '<Leader>df',
  function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end,
  { desc = "dap.ui.widgets.frames" }
)
vim.keymap.set('n', '<Leader>ds',
  function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end,
  { desc = "dap.ui.widgets.scopes" }
)
vim.keymap.set("n", "<leader>dv", function()
    require("dap-view").toggle()
  end,
  { desc = "dap-view.toggle" }
)
vim.keymap.set("n", "<leader>da", function()
    require("dap-view").add_expr()
  end,
  { desc = "dap-view.add_expr" }
)
