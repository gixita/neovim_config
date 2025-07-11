-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.loaded_neo_tree = 1
require("config.lazy")

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
vim.opt.conceallevel = 0

-- Comment this if not using a monorepo
vim.g.root_spec = { "cwd" }

require("lspconfig").ruff.setup({
  init_options = {
    settings = {
      -- Ruff language server settings go here
    },
  },
})
