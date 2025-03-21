require("nvim-treesitter.configs").setup({
  auto_install = true,
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "dockerfile",
    "gitcommit",
    "gitignore",
    "go",
    "java",
    "javascript",
    "json",
    "latex",
    "lua",
    "make",
    "markdown",
    "nix",
    "proto",
    "python",
    "scala",
    "starlark",
    "sql",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  sync_install = false,
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
