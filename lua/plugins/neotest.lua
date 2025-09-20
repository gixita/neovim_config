return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  lazy = true,
  keys = {
    { "<leader>c", group = "Code" },
    { "<leader>ct", group = "Tests" },
    { "<leader>ctt", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<leader>ctf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run tests in file" },
    { "<leader>cta", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run all tests" },
    { "<leader>cts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    { "<leader>cto", function() require("neotest").output.open({ enter = true }) end, desc = "Open test output" },
    { "<leader>ctO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
    { "<leader>ctd", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    { "<leader>ctq", function() require("neotest").run.stop() end, desc = "Stop tests" },
    { "]t", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Jump to next failed test" },
    { "[t", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Jump to previous failed test" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          runner = "pytest",
          pytest_discover_instances = false, -- Disable for better performance
          args = { "--tb=short", "--maxfail=1" }, -- Faster pytest execution
        }),
      },
      discovery = {
        enabled = true,
        concurrent = 4, -- Increase concurrent discovery
        filter_dir = function(name, rel_path, root)
          -- Skip common directories that don't contain tests
          return not vim.tbl_contains({
            ".git",
            "node_modules",
            ".venv",
            "venv",
            "__pycache__",
            ".pytest_cache",
            ".mypy_cache",
            "build",
            "dist",
          }, name)
        end,
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

    -- All keymaps are now defined in the keys table above for consistency
  end,
}
