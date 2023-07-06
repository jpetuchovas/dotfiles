local lsp = require("lsp-zero").preset({
  float_border = "rounded",
  call_servers = "local",
  configure_diagnostics = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = {
    preserve_mappings = false,
    omit = {},
  },
  manage_nvim_cmp = {
    set_sources = "recommended",
    set_basic_mappings = true,
    set_extra_mappings = false,
    use_luasnip = true,
    set_format = true,
    documentation_window = true,
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
  "lua_ls",
  "marksman",
  "nil_ls",
  "pyright",
  "tsserver",
  "yamlls",
})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
end)

lsp.set_sign_icons({
  error = "E",
  warn = "W",
  hint = "H",
  info = "I",
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    {name = "path"},
    {name = "nvim_lsp", keyword_length = 2},
    {name = "buffer", keyword_length = 2},
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({select = false}),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp_action.tab_complete(),
    ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
  },
  preselect = "item",
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
})

vim.diagnostic.config({virtual_text = true})

-- null-ls setup.
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

-- nvim-metals for Scala setup.
local metals = require("metals")
local metals_config = metals.bare_config()
metals_config.settings = {
  showImplicitArguments = true,
}
metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

local dap = require("dap")
dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}
metals_config.on_attach = function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  metals.setup_dap()
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", {clear = true})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"scala", "sbt", "java"},
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
