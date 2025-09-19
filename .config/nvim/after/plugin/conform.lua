local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = {
      "isort",
      "black",
    },
    typescript = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 5000,
  },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  conform.format({ lsp_fallback = true })
end)
