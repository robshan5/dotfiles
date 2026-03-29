return {
	"robshan5/magma-nvim",
	config = function()
		local opts = { silent = true }

		-- Normal mode keymaps
		vim.keymap.set("n", "<leader>r", ":MagmaEvaluateOperator<CR>", { silent = true, expr = true })
		vim.keymap.set("n", "<leader>rr", ":MagmaEvaluateLine<CR>", opts)
		vim.keymap.set("n", "<leader>rc", ":MagmaReevaluateCell<CR>", opts)
		vim.keymap.set("n", "<leader>rd", ":MagmaDelete<CR>", opts)
		vim.keymap.set("n", "<leader>ro", ":MagmaShowOutput<CR>", opts)

		-- Visual mode keymap
		vim.keymap.set("x", "<leader>r", ":<C-u>MagmaEvaluateVisual<CR>", opts)

		-- Magma settings
		vim.g.magma_automatically_open_output = false
		vim.g.magma_image_provider = "kitty"

		function MagmaInitPython()
			vim.cmd([[
		          :MagmaInit python3
		          :MagmaEvaluateArgument a=5
		          ]])
		end

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = "*.ipynb",
			callback = function()
				vim.bo.filetype = "python"
			end,
		})
	end,
}
