vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.smartindent = true

vim.opt.hlsearch = false

vim.opt.termguicolors = true

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"

vim.opt.spelllang = "en_us,lt"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
