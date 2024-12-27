return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      --FOR EACH NEW LSP
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        lspconfig = lspconfig,
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
        lspconfig = lspconfig,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
        lspconfig = lspconfig,
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        lspconfig = lspconfig,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            procMacro = {
              enable = true
            }
          }
        }
      })
      lspconfig.jdtls.setup({
        capabilities = capabilities,
        lspconfig = lspconfig,
      })
      lspconfig.nixd.setup({
        capabilities = capabilities,
        lspconfig = lspconfig,
        settings = {
          nix = {
            enableFlakes = true,
          }
        }
      })
    end,
  },
}
