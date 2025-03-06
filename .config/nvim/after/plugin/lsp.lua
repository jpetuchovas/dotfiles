local lsp_zero = require("lsp-zero")

lsp_zero.ui({
  sign_text = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  }
})

local cmp_nvim_lsp_default_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_attach = function(_, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})

  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
end

lsp_zero.extend_lspconfig({
  capabilities = cmp_nvim_lsp_default_capabilities,
  lsp_attach = lsp_attach,
  float_border = "rounded",
  sign_text = true,
})


require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "clangd",
    "dockerls",
    "eslint",
    "gopls",
    "jsonls",
    "lua_ls",
    "marksman",
    "nil_ls",
    "pbls",
    "pyright",
    "ts_ls",
    "yamlls",
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require("lspconfig").lua_ls.setup(lua_opts)
    end,
  },
})

local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  sources = {
    {name = "path"},
    {name = "nvim_lsp", keyword_length = 2},
    {name = "buffer", keyword_length = 2},
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({select = false}),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp_action.tab_complete(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior = "select"}),
  }),
  preselect = "item",
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
})

-- nvim-metals for Scala setup.
local metals = require("metals")
local metals_config = metals.bare_config()
metals_config.settings = {
  showImplicitArguments = true,
}
metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = cmp_nvim_lsp_default_capabilities

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
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

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
