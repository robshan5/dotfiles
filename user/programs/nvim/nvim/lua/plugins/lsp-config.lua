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
		local lspconfig = require("lspconfig")
		local on_attach = function(client, bufnr)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end
		lspconfig.nixd.setup({
			capabilities = capabilities,
			lspconfig = lspconfig,
			on_attach = on_attach,
			settings = {
				nix = {
					enableFlakes = true,
				},
			},
		})
		-- for each new lsp, add it to the list
		local servers = { "lua_ls", "pyright", "clangd", "julials", "jdtls", "tsserver", "jsonls", "eslint" }
		for _, lsp in pairs(servers) do
			lspconfig[lsp].setup({
				on_attach = on_attach,
				capabilites = capabilities,
				lspconfig = lspconfig,
			})
		end
	end,
}
