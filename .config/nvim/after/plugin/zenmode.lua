local zenmode = require("zen-mode")

zenmode.setup({
  window = {
    width = 90,
  },
})

vim.keymap.set("n", "<leader>zz", zenmode.toggle)
