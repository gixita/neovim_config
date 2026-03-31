return {
  "render-markdown.nvim",
  dir = "/home/kris/Applications/render-markdown.nvim",
  dev = true,
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  -- @module 'render-markdown'
  -- -@type render.md.UserConfig
  opts = {
    enabled = false,
    latex = {
      enabled = true,
      -- The plugin tries converters in order until one succeeds.
      -- 'utftex' requires libtexprintf. 'latex2text' requires pylatexenc.
      converter = { "latex2text" },
      highlight = "RenderMarkdownMath",
    },
  },
  keys = {
    { "<leader>cm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown render" },
  },
}

-- return {
--   "toppair/peek.nvim",
--   event = { "VeryLazy" },
--   build = "deno task --quiet build:fast",
--   config = function()
--     require("peek").setup({
--       app = "webview",
--     })
--     vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
--     vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
--   end,
-- }
