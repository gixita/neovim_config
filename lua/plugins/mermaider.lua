return {
  "snrogers/mermaider.nvim",
  dependencies = {
    "3rd/image.nvim",
  },
  config = function()
    require("mermaider").setup({
      mermaider_cmd = "mmdc -i {{IN_FILE}} -o {{OUT_FILE}}.png -s 3",
      theme = "dark",
      background_color = "#1e1e2e",
      inline_render = true,
      auto_render = true,
      auto_render_on_open = true,
      auto_preview = true,
    })
  end,
  ft = { "mmd", "mermaid" },
}
