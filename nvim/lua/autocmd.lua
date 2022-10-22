local goimports = require('goimports')

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "dart" },
  callback = function()
    --local data = {
    --  buf = vim.fn.expand("<abuf>"),
    --  file = vim.fn.expand("<afile>"),
    --  match = vim.fn.expand("<amatch>"),
    --}
    vim.schedule(function()
      --print(vim.inspect(data))
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
      vim.opt.expandtab = true
    end)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  callback = function()
    local filename = vim.fn.expand("<afile>")
    -- match *.go files
    if (string.match(string.sub(filename, -3, -1), '.go')) then
      goimports.goimports(1000)
    end
    vim.lsp.buf.format()
  end,
})
