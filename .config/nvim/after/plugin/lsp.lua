local cmp_nvim_lsp_default_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  "force",
  lspconfig_defaults.capabilities,
  cmp_nvim_lsp_default_capabilities
)

local float_border = "rounded"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf, remap = false }
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = float_border })
    end, opts)
    vim.keymap.set("i", "<C-s>", function()
      vim.lsp.buf.signature_help({ border = float_border })
    end, opts)
  end,
})

vim.diagnostic.config({ float = { border = float_border }, virtual_text = true })

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
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = cmp_nvim_lsp_default_capabilities,
      })
    end,
    lua_ls = function()
      require("lspconfig").lua_ls.setup({
        capabilities = cmp_nvim_lsp_default_capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              },
            },
          },
        },
      })
    end,
  },
})

local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "path" },
    { name = "nvim_lsp", keyword_length = 2 },
    { name = "buffer", keyword_length = 2 },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-Space>"] = cmp.mapping.complete(),
    -- Tab complete function taken from:
    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/df80878a8ac6f855a6290389340fd089870ea7a5/lua/lsp-zero/cmp-mapping.lua#L28
    ["<Tab>"] = cmp.mapping(function(fallback)
      local col = vim.fn.col(".") - 1

      if cmp.visible() then
        cmp.select_next_item()
      elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        fallback()
      else
        cmp.complete()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
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
metals_config.on_attach = function(_, _)
  metals.setup_dap()
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
