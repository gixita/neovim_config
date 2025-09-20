return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          runner = "pytest",
          pytest_discover_instances = true,
        }),
      },
      discovery = {
        enabled = true,
        concurrent = 1,
      },
      running = {
        concurrent = true,
      },
      summary = {
        enabled = true,
        expand_errors = true,
        follow = true,
      },
      output = {
        enabled = true,
        open_on_run = "short",
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = false,
      },
    })

    -- Key mappings with <leader>c prefix for code actions
    local map = vim.keymap.set

    -- Set up which-key group
    local wk = require("which-key")
    wk.add({
      { "<leader>c", group = "Code" },
      { "<leader>ct", group = "Tests" },
    })

    -- Test running with <leader>c prefix
    map("n", "<leader>ctt", function()
      require("neotest").run.run()
    end, { desc = "Run nearest test" })

    map("n", "<leader>ctf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Run tests in file" })

    map("n", "<leader>cta", function()
      require("neotest").run.run(vim.fn.getcwd())
    end, { desc = "Run all tests" })

    map("n", "<leader>cts", function()
      require("neotest").summary.toggle()
    end, { desc = "Toggle test summary" })

    map("n", "<leader>cto", function()
      require("neotest").output.open({ enter = true })
    end, { desc = "Open test output" })

    map("n", "<leader>ctO", function()
      require("neotest").output_panel.toggle()
    end, { desc = "Toggle output panel" })

    -- Test debugging (integrates with your existing DAP setup)
    map("n", "<leader>ctd", function()
      require("neotest").run.run({ strategy = "dap" })
    end, { desc = "Debug nearest test" })

    -- Stop tests
    map("n", "<leader>ctq", function()
      require("neotest").run.stop()
    end, { desc = "Stop tests" })

    -- Jump to tests
    map("n", "]t", function()
      require("neotest").jump.next({ status = "failed" })
    end, { desc = "Jump to next failed test" })

    map("n", "[t", function()
      require("neotest").jump.prev({ status = "failed" })
    end, { desc = "Jump to previous failed test" })
  end,
}
