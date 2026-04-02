return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		local border_opts = { border = "single", focusable = false }

		local function set_floating_border(opts)
			return vim.lsp.with(vim.lsp.handlers.hover, vim.tbl_extend("force", opts or {}, border_opts))
		end

		vim.lsp.handlers["textDocument/hover"] = set_floating_border()
		vim.lsp.handlers["textDocument/signatureHelp"] = set_floating_border()
		vim.lsp.handlers["textDocument/definition"] = set_floating_border()
		vim.lsp.handlers["textDocument/references"] = set_floating_border()

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(client, bufnr)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
		end

		-- nixd config
		vim.lsp.config("nixd", {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				nix = {
					enableFlakes = true,
				},
			},
		})

		-- other servers
		local servers = { "lua_ls", "pyright", "clangd", "julials", "jdtls", "jsonls", "eslint" }

		for _, server in ipairs(servers) do
			vim.lsp.config(server, {
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end

		-- enable them
		vim.lsp.enable("nixd")
		vim.lsp.enable(servers)
	end,
}
