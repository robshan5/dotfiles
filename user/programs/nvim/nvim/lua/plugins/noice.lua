return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        progress = { enabled = true },
        message = { enabled = true },
      },
      -- messages = {
      --   view = "notify",
      --   filter = { "error", "warn"},
      -- },
    },
  },
}
