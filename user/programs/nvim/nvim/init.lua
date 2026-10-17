require("config.lazy")
require("vim-options")
require("keymaps")
-- Built-in "dotfiles" scheme is generated from themes/*.nix; the plugin
-- schemes (nord, onedark, catppuccin, gruvbox) stay available as alternatives.
vim.cmd.colorscheme("dotfiles")
