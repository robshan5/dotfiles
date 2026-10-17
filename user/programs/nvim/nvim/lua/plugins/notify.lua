local ok, theme = pcall(require, "theme")
local background = ok and theme.colors.background or "#000000"

return{
  require("notify").setup({
    render = "compact",
    stages = "fade", -- Configure the fade and slide behavior
    timeout = 2000,  -- Timeout duration for the notifications
    -- nvim-notify cannot fade against a transparent window, so it blends
    -- against the terminal background colour instead.
    background_colour = background,
  })
}
