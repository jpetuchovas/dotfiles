local dap = require("dap")

vim.keymap.set("n", "<leader>acn", dap.continue)
vim.keymap.set("n", "<leader>atb", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>asv", dap.step_over)
vim.keymap.set("n", "<leader>asi", dap.step_into)
vim.keymap.set("n", "<leader>ast", dap.step_out)
vim.keymap.set("n", "<leader>arl", dap.run_last)
vim.keymap.set("n", "<leader>atr", dap.terminate)

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
      terminate = "terminate",
    },
  },
})
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

require("nvim-dap-virtual-text").setup()

require("dap-python").setup(
  "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
)

require("dap-vscode-js").setup({
  debugger_path = "/Users/justinas/.local/share/nvim/mason/packages/js-debug-adapter",
  adapters = {"pwa-node"},
})

for _, language in pairs({"typescript", "javascript"}) do
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
