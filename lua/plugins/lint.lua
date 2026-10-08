vim.pack.add({
	"https://github.com/mfussenegger/nvim-lint",
})

local lint = require("lint")

lint.linters_by_ft = {
	go = { "golangcilint" },
}

-- nvim-lint decides whether to lint a file or a directory from `go env GOMOD`
-- at startup. That reports Neovim's cwd, not the Go buffer's directory.
local go_linter = lint.linters.golangcilint
if go_linter.args then
	go_linter.args[#go_linter.args] = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return vim.fs.root(filename, "go.mod") and vim.fs.dirname(filename) or filename
	end
end

local function lint_buffer()
	if vim.bo.filetype ~= "go" then
		lint.try_lint()
		return
	end

	local filename = vim.api.nvim_buf_get_name(0)
	if filename ~= "" and go_linter.args and vim.fn.executable(go_linter.cmd) == 1 then
		lint.try_lint(nil, { cwd = vim.fs.dirname(filename) })
	end
end

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("my_lint", { clear = true }),
	callback = lint_buffer,
})

vim.keymap.set("n", "<leader>ll", lint_buffer, {
	desc = "Lint buffer",
})
