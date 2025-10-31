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
  -- Add additional colorschemes (lazy-loaded for better performance)
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "sainnhe/everforest",
    lazy = true,
  },
  {
    "nordtheme/vim",
    name = "nord",
    lazy = true,
  },
  {
    "rafi/awesome-vim-colorschemes",
    lazy = true,
    config = function()
      -- Ensure colorschemes are properly loaded
    end,
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
