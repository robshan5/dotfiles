return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        theme = "gruvbox_dark",
      },
    })
  end,
}
