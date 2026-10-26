vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	{ src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("1.*") },
})

local dap = require("dap")
local dap_view = require("dap-view")

dap_view.setup({
	auto_toggle = "keep_terminal",
	virtual_text = { enabled = true },
})

local function set_conditional_breakpoint()
	dap.set_breakpoint(vim.fn.input("Condition: "))
end

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", set_conditional_breakpoint, { desc = "Conditional breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start / continue" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
vim.keymap.set("n", "<leader>du", dap_view.toggle, { desc = "Toggle debug view" })
vim.keymap.set("n", "<leader>de", dap_view.hover, { desc = "Evaluate under cursor" })

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start / continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
