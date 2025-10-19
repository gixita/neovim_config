return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>tg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config = function()
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 1.0
    vim.g.lazygit_floating_window_use_plenary = 0

    -- Disable jj and ESC mappings in lazygit terminal
    vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
      pattern = "term://*lazygit*",
      callback = function()
        vim.keymap.set("t", "jj", "jj", { buffer = true, nowait = true })
        vim.keymap.set("t", "<ESC>", "<ESC>", { buffer = true, nowait = true })
      end,
    })
  end,
}
