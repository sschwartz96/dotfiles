local m = {}

function m.setup()
  local nvim_ts_autotag = require("nvim-ts-autotag")

  nvim_ts_autotag.setup({
    autotag = {
      enable = true,
    },
  })
end

return m
