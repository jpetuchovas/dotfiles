-- Makes Pyright pick up the virtual environment set by pyenv-virtualenv
-- correctly. The fix taken from:
-- https://github.com/neovim/nvim-lspconfig/issues/717#issuecomment-1938450468
vim.env.PYENV_VERSION = vim.fn.system("pyenv version"):match("(%S+)%s+%(.-%)")
