local conform = require("conform")

conform.setup({
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

vim.keymap.set({"n", "v"}, "<leader>f", function()
  conform.format({lsp_fallback = true})
end)
