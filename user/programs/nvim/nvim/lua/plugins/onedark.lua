return {
	"navarasu/onedark.nvim",
	priority = 1000, -- Ensure it loads first
	config = function()
		require("onedark").setup({
			transparent = true,
			style = "darker",
			code_style = {
				comments = "none",
				keywords = "underline",
				functions = "italic",
				strings = "none",
				variables = "bold",
			},
			lualine = {
				transparent = true,
			},
			diagnostics = {
				darker = true,
			},
		})
	end,
}
