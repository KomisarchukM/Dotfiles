-- ~/.config/nvim/lua/plugins/theme.lua

return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true, -- CRITICAL: Tells Gruvbox natively not to paint backgrounds
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
        },
        invert_selection = false,
        strikethrough = true,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, 
        contrast = "hard", 
        palette_overrides = {
          bright_orange = "#fe8019", 
        },
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
