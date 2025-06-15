return{
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    require("noice").setup({
      lsp = {
        progress = { enabled = true },
        message = { enabled = true }
      },
      -- messages = {
      --   view = "notify",
      --   filter = { "error", "warn"},
      -- },
    })
  },
}
