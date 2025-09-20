return {
  -- Override LazyVim colorschemes to load them for picker
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon" },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      integrations = {
        telescope = true,
        which_key = true,
        treesitter = true,
        native_lsp = { enabled = true },
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = true,
      },
    },
  },
  -- Add additional colorschemes
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
  },
  {
    "nordtheme/vim",
    name = "nord",
    lazy = false,
    priority = 1000,
  },
  {
    "rafi/awesome-vim-colorschemes",
    lazy = false,
    priority = 1000,
  },
  --  {
  --    "flazz/vim-colorschemes",
  --    lazy = false,
  --    priority = 1000,
  --  },
  -- Persistent colorscheme plugin
  {
    dir = vim.fn.stdpath("config") .. "/lua/_colour",
    name = "persistent-colorscheme",
    lazy = false,
    priority = 900,
    config = function()
      require("_colour").setup()
    end,
  },
}
