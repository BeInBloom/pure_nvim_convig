vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap-python",
})

local dap_python = require("dap-python")

dap_python.setup(vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter")

-- Without this, scripts would run in debugpy's own Mason venv.
dap_python.resolve_python = function()
	return vim.fn.exepath("python3")
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my_dap_python", { clear = true }),
	pattern = "python",
	callback = function(args)
		vim.keymap.set("n", "<leader>dn", dap_python.test_method, { buffer = args.buf, desc = "Debug nearest test" })
	end,
})
