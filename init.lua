-- bootstrap lazy.nvim, LazyVim and your plugins
-- vim.g.loaded_neo_tree = 1
require("config.lazy")

-- Suppress spurious inlay hint errors from race conditions
-- This patches vim.api.nvim_buf_set_extmark to silently ignore out-of-range errors
-- which occur when inlay hints update positions that no longer exist after line deletion
local orig_set_extmark = vim.api.nvim_buf_set_extmark
vim.api.nvim_buf_set_extmark = function(buffer, ns_id, line, col, opts)
  local success, result = pcall(orig_set_extmark, buffer, ns_id, line, col, opts)
  if not success then
    local error_msg = tostring(result)
    -- Only suppress the specific "Invalid 'col': out of range" error for inlay hints
    if error_msg:match("Invalid 'col': out of range") then
      -- Check if this is from the inlay hint namespace
      local ns_name = vim.api.nvim_get_namespaces()
      for name, id in pairs(ns_name) do
        if id == ns_id and name:match("inlayhint") then
          -- Silently ignore this error for inlay hints
          return 0
        end
      end
    end
    -- Re-raise other errors
    error(result)
  end
  return result
end

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
vim.opt.conceallevel = 0

-- Comment this if not using a monorepo
vim.g.root_spec = { "cwd" }

-- vim.api.nvim_create_autocmd({ "VimLeave", "FocusLost" }, {
--   pattern = "*",
--   command = "silent !zellij action switch-mode normal",
-- })
--
-- vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
--   pattern = "*",
--   command = "silent !zellij action switch-mode locked",
-- })
require("lspconfig").ruff.setup({
  init_options = {
    settings = {
      -- Ruff language server settings go here
    },
  },
})
