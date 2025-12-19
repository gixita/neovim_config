-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_python_lsp = "pyright"


-- Completion behavior settings
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10 -- Limit completion menu height

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.lazyvim_no_neo_tree = true

-- Enable system clipboard integration (Wayland)
vim.opt.clipboard = "unnamedplus"
