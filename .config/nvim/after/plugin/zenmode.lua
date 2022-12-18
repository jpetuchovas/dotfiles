local zenmode = require("zen-mode")

zenmode.setup({
  window = {
    width = 94,
  },
})

vim.keymap.set("n", "<leader>zz", zenmode.toggle)
