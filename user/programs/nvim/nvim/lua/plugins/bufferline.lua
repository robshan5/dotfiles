return {
  "willothy/nvim-cokeline",
  dependencies = {
    "stevearc/resession.nvim",
  },
  config = function()
      vim.keymap.set("n", "<leader>bp", function()
        require("cokeline.mappings").pick("focus")
      end, { desc = "Pick a buffer to focus" })
      vim.keymap.set({ "n", "i" }, "<C-x>", ":bp<cr>:bd#<cr>")

      local is_picking_focus = require("cokeline.mappings").is_picking_focus
      local is_picking_close = require("cokeline.mappings").is_picking_close
      local get_hex = require("cokeline.hlgroups").get_hl_attr

      local red = vim.g.terminal_color_1
      local yellow = vim.g.terminal_color_3

      require("cokeline").setup({
        ---@type integer
        show_if_buffers_are_at_least = 1,

        default_hl = {
          fg = function(buffer)
            return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
          end,
          bg = function()
            return get_hex("ColorColumn", "bg")
          end,
        },

        sidebar = {
          filetype = { "NvimTree", "neo-tree" },
          components = {
            {
              text = function(buf)
                return buf.filetype
              end,
              fg = yellow,
              bg = function()
                return get_hex("NvimTreeNormal", "bg")
              end,
              bold = true,
            },
          },
        },

        components = {
          {
            text = function(buffer)
              return (buffer.index ~= 1) and "▏" or ""
            end,
          },
          {
            text = "  ",
          },
          {
            text = function(buffer)
              return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. " "
                  or buffer.devicon.icon
            end,
            fg = function(buffer)
              return (is_picking_focus() and yellow) or (is_picking_close() and red) or buffer.devicon.color
            end,
            italic = function()
              return (is_picking_focus() or is_picking_close())
            end,
            bold = function()
              return (is_picking_focus() or is_picking_close())
            end,
          },
          {
            text = " ",
          },
          {
            text = function(buffer)
              return buffer.filename .. "  "
            end,
            bold = function(buffer)
              return buffer.is_focused
            end,
          },
          {
            text = "X",
            on_click = function(_, _, _, _, buffer)
              buffer:delete()
            end,
          },
          {
            text = "  ",
          },
        },
      })
  end,
}

