-- Remove trailing whitespace on save.
vim.api.nvim_create_autocmd("BufWritePre", {command = [[%s/\s\+$//e]]})
