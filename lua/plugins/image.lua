return {
  "3rd/image.nvim",
  build = false,
  opts = {
    backend = "kitty",
    processor = "magick_cli",
    integrations = {
      markdown = {
        enabled = true,
        only_render_image_at_cursor = true,
        only_render_image_at_cursor_mode = "inline",
      },
    },
  },
  config = function(_, opts)
    require("image").setup(opts)
    require("image").disable()
  end,
}
