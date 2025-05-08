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
