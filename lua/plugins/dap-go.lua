vim.pack.add({
	"https://github.com/leoluz/nvim-dap-go",
})

local dap_go = require("dap-go")

dap_go.setup()

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my_dap_go", { clear = true }),
	pattern = "go",
	callback = function(args)
		vim.keymap.set("n", "<leader>dn", dap_go.debug_test, { buffer = args.buf, desc = "Debug nearest test" })
	end,
})
