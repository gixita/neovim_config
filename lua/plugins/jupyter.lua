return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim", "quarto-dev/quarto-nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20

      -- Set output sticky behavior
      vim.g.molten_virt_text_output = true -- Keep output windows open when moving cursor
    end,
    config = function()
      -- Add an autocmd to run MoltenInit only for ipynb files
      vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = "*.ipynb",
        --group = molten_group,
        callback = function()
          -- Check if MoltenInit has been run already
          local molten_initialized = vim.g.molten_initialized or false
          if not molten_initialized then
            vim.cmd("MoltenInit")
            vim.cmd("QuartoActivate")
            vim.g.molten_initialized = true
          end
        end,
      })
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.ipynb",
        callback = function()
          vim.cmd("MoltenInit")
          -- And/or
          vim.cmd("QuartoActivate")
        end,
        group = vim.api.nvim_create_augroup("JupyterCommands", { clear = true }),
      })
    end,
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
  { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
    -- for complete functionality (language features)
    "quarto-dev/quarto-nvim",
    dev = false,
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    dependencies = {
      -- for language features in code cells
      -- configured in lua/plugins/lsp.lua
      "jmbuhr/otter.nvim",
    },
    config = function(_, opts)
      require("quarto").setup(opts)

      -- Access the runner module
      local runner = require("quarto.runner")
      local wk = require("which-key")
      wk.add({
        { "<leader>r", group = "Jupyter run" },
      })
      -- Add your keymaps
      vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "Jupyter run cell", silent = true })
      vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "Jupyter run cell and above", silent = true })
      vim.keymap.set("n", "<leader>rA", runner.run_all, { desc = "Jupyter run all cells", silent = true })
      vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "Jupyter run line", silent = true })
      vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "Jupyter run visual range", silent = true })
      vim.keymap.set("n", "<leader>rF", function()
        runner.run_all(true)
      end, { desc = "run all cells (forced)", silent = true })
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto", -- you can set whatever filetype you want here
        },
      },
      lazy = false,
    },
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    -- lazy=false,
  },
}
