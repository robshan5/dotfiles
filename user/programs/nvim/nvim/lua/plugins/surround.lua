return {
	"kylechui/nvim-surround",
  lazy = false,
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({})
	end,
}
