vim.g.mapleader = " "

vim.keymap.set({"n", "v"}, "<leader>K", "K")

vim.keymap.set("n", "<leader>fv", vim.cmd.Ex)

-- Allows to move selected lines in visual mode.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Centers text to the middle of the screen when moving half page up or down.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Centers text to the middle of the screen when searching.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Pastes text without overwriting the last yank.
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Deletes text without overwriting the last yank.
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Copies to the clipboard.
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- Makes a search pattern to replace the word under the cursor.
vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

-- Open the current line in GitHub.
-- %:. refers to the relative path of the current file.
-- <C-r>=line(".")<CR> gets the current line number.
vim.keymap.set(
  "n",
  "<leader>gho",
  ':!gh browse -c=$(git rev-parse HEAD) %:.:<C-r>=line(".")<CR><CR><CR>'
)

-- Copies the current buffer's directory to clipboard.
vim.keymap.set("n", "cpd", ':let @+=expand("%:p:h")<CR>')
