require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "gitcommit",
    "gitignore",
    "go",
    "help",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "proto",
    "python",
    "typescript",
    "vim",
    "yaml",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})
