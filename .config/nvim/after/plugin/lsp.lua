local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
  "bufls",
  "eslint",
  "gopls",
  "pyright",
  "sumneko_lua",
  "tsserver",
})

lsp.nvim_workspace()

lsp.setup()
