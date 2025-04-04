local plugins = {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  "nvim-treesitter/playground",

  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
  },
  "ThePrimeagen/harpoon",

  "mbbill/undotree",

  "numToStr/Comment.nvim",

  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",

  -- LSP Support.
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    build = function()
      pcall(vim.cmd, "MasonUpdate")
    end,
  },
  "williamboman/mason-lspconfig.nvim",

  -- Autocompletion.
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp",

  "mfussenegger/nvim-lint",
  "stevearc/conform.nvim",
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },
  "theHamsta/nvim-dap-virtual-text",
  "mfussenegger/nvim-dap-python",
  { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },

  "folke/zen-mode.nvim",
}

local opts = {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)
