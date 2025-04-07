local enrich_config = function(finalConfig, on_config)
  local final_config = vim.deepcopy(finalConfig)

  -- Placeholder expansion for launch directives
  local placeholders = {
    ["${file}"] = function(_)
      return vim.fn.expand("%:p")
    end,
    ["${fileBasename}"] = function(_)
      return vim.fn.expand("%:t")
    end,
    ["${fileBasenameNoExtension}"] = function(_)
      return vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r")
    end,
    ["${fileDirname}"] = function(_)
      return vim.fn.expand("%:p:h")
    end,
    ["${fileExtname}"] = function(_)
      return vim.fn.expand("%:e")
    end,
    ["${relativeFile}"] = function(_)
      return vim.fn.expand("%:.")
    end,
    ["${relativeFileDirname}"] = function(_)
      return vim.fn.fnamemodify(vim.fn.expand("%:.:h"), ":r")
    end,
    ["${workspaceFolder}"] = function(_)
      return vim.fn.getcwd()
    end,
    ["${workspaceFolderBasename}"] = function(_)
      return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    end,
    ["${env:([%w_]+)}"] = function(match)
      return os.getenv(match) or ""
    end,
  }

  if final_config.envFile then
    local filePath = final_config.envFile
    for key, fn in pairs(placeholders) do
      filePath = filePath:gsub(key, fn)
    end

    for line in io.lines(filePath) do
      local words = {}

      -- handle blank lines
      if line == "" then
        print("blank line, skipping")
        goto continue
      end

      -- handle comments
      if string.find(line, "^#") then
        print("string with comment, skipping")
        goto continue
      end

      for word in string.gmatch(line, "[^=]+") do
        table.insert(words, word)
      end
      if not final_config.env then
        print("here")
        final_config.env = {}
      end
      print(string.format("%s = %s", words[1], words[2]))
      final_config.env[words[1]] = words[2]
      ::continue::
    end
  end

  on_config(final_config)
end

return {
  -- debug plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = { "igorlfs/nvim-dap-view", opts = {} },
    config = function()
      local dap = require("dap")

      dap.adapters.go = {
        type = "server",
        port = 38697,
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:38697" },
        },
        output = "remote",
        enrich_config = enrich_config,
      }
    end
  },

  -- debug view
  -- {
  --   "igorlfs/nvim-dap-view",
  --   -- opts = {},
  -- },

  -- debug ui
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = { { "nvim-neotest/nvim-nio" } },
  --   config = function()
  --     require("dapui").setup()
  --   end
  -- },
  --
  -- debug virtual text
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },
  --
  -- go specfic config
  -- {
  --   "leoluz/nvim-dap-go",
  --   config = function()
  --     require("dap-go").setup({})
  --   end
  -- },

}
