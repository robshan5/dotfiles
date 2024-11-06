return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	lazy = false,
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				--ALL FORMATERS AND LINTERS (INSTALL WITH MASON)
				--LUA
				null_ls.builtins.formatting.stylua,
				--PYTHON
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.diagnostics.mypy,
				require("none-ls.diagnostics.ruff"),
				--C
				--null_ls.builtins.diagnostics.clangd,
				null_ls.builtins.formatting.clang_format,
				--Rust
				require("none-ls.formatting.rustfmt"),
				--Java
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({
						group = augroup,
						buffer = bufnr,
					})
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
