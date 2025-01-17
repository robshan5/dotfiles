return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.keybinds"] = {},
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.journal"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Notes/",
            college = "~/College",
          },
          default_workspace = "college",
        },
      },
    },
  },
  vim.keymap.set("n", "<S-n>", ":Neorg<cr>", {}),
}
