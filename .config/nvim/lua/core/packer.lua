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

  use("numToStr/Comment.nvim")

  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")

  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
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

      -- Snippets
      {"L3MON4D3/LuaSnip"},
    }
  })
  use("jose-elias-alvarez/null-ls.nvim")
  use({
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  })

  use({"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}})
  use("theHamsta/nvim-dap-virtual-text")
  use("mfussenegger/nvim-dap-python")
  use({"mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"}})

  use("folke/zen-mode.nvim")
end)
