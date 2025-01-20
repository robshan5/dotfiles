return{
  "jzone1366/twilight.nvim",
    require("twilight").setup({
      style = "dark",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = "italic", -- change style of comments to be italic
        keywords = "bold", -- change style of keywords to be bold
        functions = "italic,bold" -- styles can be a comma separated list
      },
    })
}
