-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "jj", "<C-\\><C-n>")
map("n", "<leader>zz", "<leader>w_")

-- Jump navigation keymaps
local wk = require("which-key")
wk.add({
  { "<C-o>", "<C-o>", desc = "Jump back in jumplist" },
  { "<C-i>", "<C-i>", desc = "Jump forward in jumplist" },
  { "<leader>sz", group = "Spell check tools" },
  { "<leader>cz", group = "Fold code" },
})

-- Fold code keymaps
map("n", "<leader>cza", "za", { desc = "Toggle fold at cursor" })
map("n", "<leader>czo", "zR", { desc = "Open all folds" })
map("n", "<leader>czc", "zM", { desc = "Close all folds" })
map("n", "<leader>czm", "zc", { desc = "Close fold at cursor" })
map("n", "<leader>czr", "zo", { desc = "Open fold at cursor" })
map("n", "<leader>czj", "zj", { desc = "Move to next fold" })
map("n", "<leader>czk", "zk", { desc = "Move to previous fold" })
-- Custom spell suggestion function using vim.ui.select
local function spell_suggest()
  local word = vim.fn.expand("<cword>")
  local suggestions = vim.fn.spellsuggest(word, 10)

  if #suggestions == 0 then
    vim.notify("No spell suggestions for: " .. word)
    return
  end

  vim.ui.select(suggestions, {
    prompt = "Spell suggestions for '" .. word .. "':",
  }, function(choice)
    if choice then
      vim.cmd("normal! ciw" .. choice)
    end
  end)
end

map("n", "<leader>sz=", spell_suggest, { desc = "Spell suggestions" })
map("n", "<leader>szs", spell_suggest, { desc = "Spell suggestions" })
map("n", "<leader>sza", "zg", { desc = "Add word to dictionary" })
map("n", "<leader>szr", "zw", { desc = "Remove word from dictionary" })
map("n", "<leader>szu", "zug", { desc = "Undo add word to dictionary" })
map("n", "<leader>szn", "]s", { desc = "Next misspelled word" })
map("n", "<leader>szp", "[s", { desc = "Previous misspelled word" })
map("n", "<leader>sze", function()
  vim.opt.spelllang = { "en" }
end, { desc = "Switch to English spelling" })
map("n", "<leader>szf", function()
  vim.opt.spelllang = { "fr" }
end, { desc = "Switch to French spelling" })
map("n", "<leader>szb", function()
  vim.opt.spelllang = { "en", "fr" }
end, { desc = "Use both English and French" })
map("n", "<leader>szt", function()
  vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spell checking" })
