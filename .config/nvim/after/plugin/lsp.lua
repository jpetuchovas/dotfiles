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

lsp.set_preferences({
  sign_icons = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  },
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
end)

lsp.nvim_workspace()

lsp.setup()

vim.diagnostic.config({virtual_text = true})
