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

local function lint_buffer(args)
	local bufnr = args and args.buf or vim.api.nvim_get_current_buf()
	if vim.bo[bufnr].filetype ~= "go" then
		lint.try_lint()
		return
	end

	local filename = vim.api.nvim_buf_get_name(bufnr)
	if filename ~= "" and go_linter.args and vim.fn.executable(go_linter.cmd) == 1 then
		lint.try_lint(nil, { cwd = vim.fs.dirname(filename) })
		-- Re-run for hidden buffers saved by :wall, because nvim-lint
		-- publishes diagnostics only for the current buffer via buffer 0.
		if bufnr ~= vim.api.nvim_get_current_buf() then
			vim.api.nvim_buf_call(bufnr, lint.try_lint)
		end
	end
end

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("my_lint", { clear = true }),
	callback = lint_buffer,
})

vim.keymap.set("n", "<leader>ll", lint_buffer, {
	desc = "Lint buffer",
})
