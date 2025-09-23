return {

  "mason-org/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      "ruff",
      "pyright",
      "mypy",
      "debugpy",
      "isort",
    },
  },
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          -- Add delay and check to prevent race condition
          vim.defer_fn(function()
            if not p:is_installed() then
              local ok, err = pcall(function() p:install() end)
              if not ok and err and not err:match("already installing") then
                vim.notify("Mason install error for " .. tool .. ": " .. err, vim.log.levels.WARN)
              end
            end
          end, math.random(50, 200)) -- Random delay to prevent simultaneous installs
        end
      end
    end)
  end,
}
