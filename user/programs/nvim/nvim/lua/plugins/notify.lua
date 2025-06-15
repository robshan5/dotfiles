return{
  require("notify").setup({
    render = "compact",
    stages = "fade", -- Configure the fade and slide behavior
    timeout = 2000,  -- Timeout duration for the notifications
    background_colour = "#161b22",  -- Background color for the notification window
  })
}
