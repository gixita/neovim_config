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
  -- Disable global spell checking for better performance
  vim.opt.spell = false

  -- Set the default spelling languages to English and French
  vim.opt.spelllang = { "en", "fr" }

  -- Configure spell suggestions to show in command line instead of new window
  vim.opt.spellsuggest = "best,9"

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

-- Spell keymaps are now in lua/config/keymaps.lua under <leader>sz prefix

-- Force normal mode when losing focus (helps with Zellij tab switching)
-- vim.api.nvim_create_autocmd({ "FocusLost" }, {
--   pattern = "*",
--   callback = function()
--     if vim.fn.mode() ~= "n" then
--       vim.cmd("stopinsert")
--       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
--     end
--   end,
-- })
