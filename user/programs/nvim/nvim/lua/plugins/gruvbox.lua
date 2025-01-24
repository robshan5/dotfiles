return{
  "ellisonleao/gruvbox.nvim",
  priority = 1000, -- Load this plugin first for the colorscheme
  lazy = false,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      transparent_mode = true,
    })
  end,
}
