vim.pack.add({
	"https://github.com/mfussenegger/nvim-lint",
})

local lint = require("lint")

lint.linters_by_ft = {
	go = { "golangcilint" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("my_lint", { clear = true }),
	callback = function()
		lint.try_lint()
	end,
})

vim.keymap.set("n", "<leader>ll", function()
	lint.try_lint()
end, {
	desc = "Lint buffer",
})
