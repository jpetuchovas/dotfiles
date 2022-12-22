-- Removes trailing whitespace on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    -- keeppatterns makes it so that the search history is not altered.
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor_position)
  end,
})
