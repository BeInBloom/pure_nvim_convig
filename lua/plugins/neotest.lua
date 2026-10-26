vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
	{ src = "https://github.com/nvim-neotest/neotest", version = vim.version.range("^5") },
	{ src = "https://github.com/fredrikaverpil/neotest-golang", version = vim.version.range("^2") },
	"https://github.com/nvim-neotest/neotest-python",
})

local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-golang")(),
		require("neotest-python"),
		require("rustaceanvim.neotest"),
	},
})

local function run_file()
	neotest.run.run(vim.fn.expand("%"))
end

local function run_all()
	neotest.run.run(vim.uv.cwd())
end

local function open_output()
	neotest.output.open({ enter = true, auto_close = true })
end

vim.keymap.set("n", "<leader>tr", neotest.run.run, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tt", run_file, { desc = "Run file tests" })
vim.keymap.set("n", "<leader>tT", run_all, { desc = "Run all tests" })
vim.keymap.set("n", "<leader>tl", neotest.run.run_last, { desc = "Run last test" })
vim.keymap.set("n", "<leader>tS", neotest.run.stop, { desc = "Stop tests" })
vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Toggle test summary" })
vim.keymap.set("n", "<leader>to", open_output, { desc = "Test output" })
vim.keymap.set("n", "<leader>tO", neotest.output_panel.toggle, { desc = "Toggle test output panel" })
