require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("sainnhe/gruvbox-material")
  use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
end)
