local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.setup_nvim_cmp({
  sources = {
    {name = "path"},
    {name = "nvim_lsp", keyword_length = 2},
    {name = "buffer", keyword_length = 2},
  },
})

lsp.ensure_installed({
  "bashls",
  "bufls",
  "clangd",
  "dockerls",
  "eslint",
  "gopls",
  "jsonls",
  "marksman",
  "pyright",
  "sumneko_lua",
  "texlab",
  "tsserver",
  "yamlls",
})

lsp.set_preferences({
  sign_icons = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  },
})

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
end)

lsp.nvim_workspace()

lsp.configure("texlab", {
  settings = {
    texlab = {
      build = {
        forwardSearchAfter = true,
        onSave = true,
      },
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = {"%l", "%p", "%f"},
      },
    },
  },
})

lsp.setup()

vim.diagnostic.config({virtual_text = true})

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local filetypes_to_format_on_save = {
  "python",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
}
local function should_format(buffer_filetype)
  for _, filetype in pairs(filetypes_to_format_on_save) do
    if filetype == buffer_filetype then
      return true
    end
  end

  return false
end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.shfmt,
  },
  -- Formats on save.
  on_attach = function(client, bufnr)
    if should_format(vim.bo[bufnr].filetype)
        and client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(clnt)
              return clnt.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
})
