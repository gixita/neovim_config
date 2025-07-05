return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      -- Disable automatic confirmation on Enter
      ["<CR>"] = {},
      -- Use Ctrl+y to manually confirm completion
      ["<C-y>"] = { "accept", "fallback" },
      -- Use Tab to accept completion
      ["<Tab>"] = { "accept", "fallback" },
      -- Use Ctrl+Space to manually trigger completion
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      -- Navigate completions
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      -- Cancel completion
      ["<C-e>"] = { "hide", "fallback" },
    },
    completion = {
      -- Don't automatically select first item
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      -- Make completion less aggressive
      trigger = {
        prefetch_on_insert = false,
        show_on_insert_on_trigger_character = false,
      },
      -- Don't auto-confirm
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },
    -- Reduce completion menu interference
    appearance = {
      -- Reduce completion menu frequency
      trigger_completion = {
        blocked_trigger_characters = { ":", ".", "(", ")" },
      },
    },
  },
}