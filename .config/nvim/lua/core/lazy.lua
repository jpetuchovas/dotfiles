local plugins = {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
  },
  "nvim-treesitter/playground",

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    dependencies = {"nvim-lua/plenary.nvim"}
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

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support.
      {"neovim/nvim-lspconfig"},
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      {"williamboman/mason-lspconfig.nvim"},

      -- Autocompletion.
      {"hrsh7th/nvim-cmp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"saadparwaiz1/cmp_luasnip"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-nvim-lua"},

      -- Snippets
      {"L3MON4D3/LuaSnip"},
    }
  },
  "jose-elias-alvarez/null-ls.nvim",
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  },

  {"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}},
  "theHamsta/nvim-dap-virtual-text",
  "mfussenegger/nvim-dap-python",
  {"mxsdev/nvim-dap-vscode-js", dependencies = {"mfussenegger/nvim-dap"}},

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
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)
