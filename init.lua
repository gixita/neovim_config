-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lspconfig").ruff.setup({
  init_options = {
    settings = {
      -- Ruff language server settings go here
    },
  },
})
