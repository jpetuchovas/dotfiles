local zenmode = require("zen-mode")

zenmode.setup()

vim.keymap.set("n", "<leader>zz", zenmode.toggle)
