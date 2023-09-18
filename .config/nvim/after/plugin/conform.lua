require("conform").setup({
  formatters_by_ft = {
    python = {
      "isort",
      "black",
    },
  },
  format_on_save = {
    timeout_ms = 500,
  },
})
