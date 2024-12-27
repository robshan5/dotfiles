require("config.lazy")
---@diagnostic disable-next-line: different-requires
require("lazy").setup("plugins")
require("vim-options")
require("keymaps")
vim.cmd.colorscheme("nord")
-- vim.cmd.colorscheme("catppuccin")
