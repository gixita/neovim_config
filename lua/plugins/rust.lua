return {
  -- Disable default rust-analyzer from lspconfig (rustaceanvim handles it)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = false, -- Disable, rustaceanvim handles it
      },
    },
  },

  -- Rustaceanvim - Enhanced Rust experience
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            -- Keybindings for Rust-specific features
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.keymap.set("n", "<leader>ca", function()
              vim.cmd.RustLsp("codeAction")
            end, vim.tbl_extend("force", opts, { desc = "Code Action" }))
            vim.keymap.set("n", "<leader>dr", function()
              vim.cmd.RustLsp("debuggables")
            end, vim.tbl_extend("force", opts, { desc = "Rust Debuggables" }))
            vim.keymap.set("n", "<leader>rr", function()
              vim.cmd.RustLsp("runnables")
            end, vim.tbl_extend("force", opts, { desc = "Rust Runnables" }))
            vim.keymap.set("n", "<leader>rt", function()
              vim.cmd.RustLsp("testables")
            end, vim.tbl_extend("force", opts, { desc = "Rust Testables" }))
            vim.keymap.set("n", "K", function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end, vim.tbl_extend("force", opts, { desc = "Hover Actions" }))
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = false, -- Only load default features for better performance
              },
              checkOnSave = {
                command = "check", -- Use 'check' instead of 'clippy' for faster checks
              },
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              completion = {
                autoimport = {
                  enable = true, -- Enable auto-import suggestions
                },
              },
            },
          },
        },
      }
    end,
  },

  -- Crates.io integration for Cargo.toml
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },

  -- Autoformatting for Rust
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
      },
      formatters = {
        rustfmt = {
          -- Only format stdin, don't check project-wide
          args = { "--edition=2021" },
          stdin = true,
        },
      },
    },
  },

  -- Treesitter for Rust
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "rust", "toml" },
    },
  },
}
