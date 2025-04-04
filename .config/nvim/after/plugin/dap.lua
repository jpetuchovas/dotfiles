local dap = require("dap")

vim.keymap.set("n", "<leader>ba", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>bc", dap.continue)
vim.keymap.set("n", "<leader>bh", dap.step_back)
vim.keymap.set("n", "<leader>bj", dap.step_into)
vim.keymap.set("n", "<leader>bk", dap.step_out)
vim.keymap.set("n", "<leader>bl", dap.step_over)
vim.keymap.set("n", "<leader>b.", dap.run_to_cursor)
vim.keymap.set("n", "<leader>br", dap.run_last)
vim.keymap.set("n", "<leader>bL", dap.list_breakpoints)
vim.keymap.set("n", "<leader>bJ", dap.down)
vim.keymap.set("n", "<leader>bK", dap.up)
vim.keymap.set("n", "<leader>bx", dap.clear_breakpoints)
vim.keymap.set("n", "<leader>bX", dap.terminate)

local dapui = require("dapui")
dapui.setup({
  icons = {
    expanded = "v",
    collapsed = ">",
    current_frame = ">",
  },
  controls = {
    icons = {
      pause = "||",
      play = ">",
      step_into = "into",
      step_over = "over",
      step_out = "out",
      step_back = "back",
      run_last = "last",
      terminate = "X",
    },
  },
})
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

require("nvim-dap-virtual-text").setup()

require("dap-python").setup("~/.pyenv/shims/python")

require("dap-vscode-js").setup({
  debugger_path = os.getenv("HOME")
    .. "/.local/share/nvim/mason/packages/js-debug-adapter",
  adapters = { "pwa-node" },
})

for _, language in pairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end
