return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = { --[[ things you want to change go here]]
	},
	config = function()
		require("toggleterm").setup({
			size = vim.o.columns * 0.4,
			persist_size = false,
			open_mapping = [[<c-/>]],
			direction = "float",
			start_in_insert = true,
			close_on_exit = true,
			persist_size = true,
			insert_mappings = true,
			hide_numbers = true,
			shade_filetypes = {},
			shading_factor = 2,
			shell = "zsh",
			float_opts = {
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})
	end,
}
