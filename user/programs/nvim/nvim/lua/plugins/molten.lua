return {
	"benlubas/molten-nvim",
	config = function()
		vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
		vim.keymap.set(
			"n",
			"<localleader>e",
			":MoltenEvaluateOperator<CR>",
			{ silent = true, desc = "run operator selection" }
		)
		vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
		vim.keymap.set(
			"n",
			"<localleader>rr",
			":MoltenReevaluateCell<CR>",
			{ silent = true, desc = "re-evaluate cell" }
		)
		vim.keymap.set(
			"v",
			"<localleader>r",
			":<C-u>MoltenEvaluateVisual<CR>gv",
			{ silent = true, desc = "evaluate visual selection" }
		)
	end,
}
