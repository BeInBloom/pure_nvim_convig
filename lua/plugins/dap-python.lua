vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap-python",
})

local dap_python = require("dap-python")

dap_python.setup(vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter")

-- All Python code is debugged with the system python3, even inside a project:
-- its .venv is ignored unless $VIRTUAL_ENV (or $CONDA_PREFIX) is set. Behavior
-- that differs from `uv run` or the project's interpreter may come from here.
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
