require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use("sainnhe/gruvbox-material")

  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  })
  use("nvim-treesitter/playground")

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = {{"nvim-lua/plenary.nvim"}}
  })
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    cond = vim.fn.executable("make") == 1,
  })
  use("ThePrimeagen/harpoon")

  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")

  use({
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support.
      {"neovim/nvim-lspconfig"},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},

      -- Autocompletion.
      {"hrsh7th/nvim-cmp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"saadparwaiz1/cmp_luasnip"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-nvim-lua"},

      -- Snippets.
      {"L3MON4D3/LuaSnip"},
      {"rafamadriz/friendly-snippets"},
    }
  })

  use({"folke/zen-mode.nvim"})
end)
