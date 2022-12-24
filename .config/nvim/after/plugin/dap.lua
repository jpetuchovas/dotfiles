local dap = require("dap")

vim.keymap.set("n", "<leader>acn", dap.continue)
vim.keymap.set("n", "<leader>atb", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>asv", dap.step_over)
vim.keymap.set("n", "<leader>asi", dap.step_into)
vim.keymap.set("n", "<leader>ast", dap.step_out)
vim.keymap.set("n", "<leader>arl", dap.run_last)
vim.keymap.set("n", "<leader>atr", dap.terminate)

local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

require("nvim-dap-virtual-text").setup()

require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
