local M = {}

local set_colourscheme = require("_colour.colourscheme")

M.setup = function()
  set_colourscheme()

  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(args)
      -- Update the colorscheme file when any colorscheme changes
      local config_file = vim.fn.stdpath("config") .. "/lua/_colour/colourscheme.lua"
      vim.fn.jobstart(
        "sed -i 's/\\[\\[colorscheme .*\\]\\]/[[colorscheme "
          .. args.match
          .. "]]/' "
          .. config_file
      )
      vim.notify("Colorscheme '" .. args.match .. "' saved as default!")
    end,
  })
end

return M