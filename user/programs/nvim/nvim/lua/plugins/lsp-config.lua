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
}
