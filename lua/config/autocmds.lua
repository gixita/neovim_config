-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
local function setup_spelling()
  -- Enable spell checking globally
  vim.opt.spell = true

  -- Set the default spelling languages to English and French
  vim.opt.spelllang = { "en", "fr" }

  -- Optional: Set the spellfile location (for adding words)
  vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add,~/.config/nvim/spell/fr.utf-8.add")

  -- Optional: Create spell directories if they don't exist
  local spell_dir = vim.fn.expand("~/.config/nvim/spell")
  if vim.fn.isdirectory(spell_dir) == 0 then
    vim.fn.mkdir(spell_dir, "p")
  end
end

-- Set up spelling when Neovim starts
setup_spelling()

-- Optional: File-specific spell settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "tex", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Optional: Custom keymaps for spell checking
vim.keymap.set("n", "<leader>se", function()
  vim.opt.spelllang = { "en" }
end, { desc = "Switch to English spelling" })
vim.keymap.set("n", "<leader>sf", function()
  vim.opt.spelllang = { "fr" }
end, { desc = "Switch to French spelling" })
vim.keymap.set("n", "<leader>sb", function()
  vim.opt.spelllang = { "en", "fr" }
end, { desc = "Use both English and French" })
vim.keymap.set("n", "<leader>sn", function()
  vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spell checking" })
