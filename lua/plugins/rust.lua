return {
  -- Rust LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = false, -- Only load default features for better performance
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = {
                command = "check", -- Use 'check' instead of 'clippy' for faster checks
              },
              procMacro = {
                enable = true,
              },
              diagnostics = {
                enable = true,
                experimental = {
                  enable = false, -- Disable experimental diagnostics for performance
                },
              },
              inlayHints = {
                bindingModeHints = {
                  enable = false,
                },
                chainingHints = {
                  enable = true,
                },
                closingBraceHints = {
                  minLines = 25,
                },
                closureReturnTypeHints = {
                  enable = "never",
                },
                lifetimeElisionHints = {
                  enable = "never",
                  useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                  enable = true,
                },
                reborrowHints = {
                  enable = "never",
                },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },
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
            -- Disable inlay hints to avoid rendering errors
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })

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
