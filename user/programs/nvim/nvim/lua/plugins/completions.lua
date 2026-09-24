return {
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
  },
  {
    "dcampos/nvim-snippy",
    lazy = false,
    config = function()
      require("snippy").setup({
        mappings = {
          is = {
            ["<Tab>"] = "expand_or_advance",
            ["<S-Tab>"] = "previous",
          },
          nx = {
            ["<leader>x"] = "cut_text",
          },
        },
      })
    end,
  },
  {
    "dcampos/cmp-snippy",
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "dcampos/nvim-snippy",
      "dcampos/cmp-snippy",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
      snippet = {
        expand = function(args)
          require('snippy').expand_snippet(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item() -- Cycle to the next completion
          elseif require('snippy').can_expand_or_advance() then
            require('snippy').expand_or_advance() -- Expand or advance snippet
          else
            fallback() -- Fall back to the default behavior (e.g., insert a tab)
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item() -- Cycle to the previous completion
          elseif require('snippy').can_expand_or_advance() then
            require('snippy').previous() -- Go to previous snippet part
          else
            fallback() -- Fall back to the default behavior (e.g., insert a tab)
          end
        end, { "i", "s" }),

        ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion manually
        ["<C-e>"] = cmp.mapping.abort(), -- Close the completion menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm the currently selected item
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "snippy" },
      }, {
        { name = "buffer" },
      }),
    })
    end,
  },
}
