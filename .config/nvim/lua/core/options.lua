vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.smartindent = true

vim.opt.hlsearch = false

vim.opt.termguicolors = true

vim.opt.swapfile = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 4

vim.opt.colorcolumn = "80"

vim.opt.spelllang = "en_us,lt"

vim.g.netrw_bufsettings = "noma nomod nonu nowrap ro nobl nu rnu"
