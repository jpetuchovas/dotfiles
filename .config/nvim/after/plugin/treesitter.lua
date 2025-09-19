local filetypes = {
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
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function()
    vim.treesitter.start()
  end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

require("nvim-treesitter").install(filetypes)
