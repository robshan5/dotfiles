return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		-- Statusline colours come from the same Nix-generated palette as the
		-- "dotfiles" colourscheme; fall back to lualine's auto theme without it.
		local function statusline_theme()
			local loaded, theme = pcall(require, "theme")
			if not loaded then
				return "auto"
			end

			local c = theme.colors
			local bg = theme.transparent and "NONE" or c.surface
			local inactive = { fg = c.comment, bg = bg }

			local function mode(color)
				return {
					a = { fg = c.background, bg = color, gui = "bold" },
					b = { fg = color, bg = bg },
					c = { fg = c.foreground, bg = bg },
				}
			end

			return {
				normal = mode(c.blue),
				insert = mode(c.green),
				visual = mode(c.magenta),
				replace = mode(c.red),
				command = mode(c.accent),
				terminal = mode(c.cyan),
				inactive = { a = inactive, b = inactive, c = inactive },
			}
		end

		require("lualine").setup({
			options = {
				theme = statusline_theme(),
			},
		})
	end,
}
