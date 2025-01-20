vim.g.lazyvim_json = "/home/robshan/nix-config/user/programs/nvim/nvim/.luarc.json"
require("config.lazy")
require("vim-options")
require("keymaps")
require("lazy").setup("plugins")
-- vim.cmd.colorscheme("nord")
vim.cmd.colorscheme("onedark")
-- vim.cmd.colorscheme("catppuccin")
