local telescope = require("telescope")

-- Don't use treesitter in the preview screen.
-- Fixes the error that happens after switching
-- to treesitter's main branch.
-- See GitHub issue:
-- https://github.com/nvim-telescope/telescope.nvim/issues/3487#issuecomment-3047102892
telescope.setup({
  defaults = {
    preview = {
      treesitter = false,
    },
  },
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files)
vim.keymap.set("n", "<leader>fs", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
