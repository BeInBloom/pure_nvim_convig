local ag = vim.api.nvim_create_augroup

local highlight_group = ag("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 170 })
	end,
	group = highlight_group,
})

vim.opt.autoread = true

local timer = vim.uv.new_timer()

timer:start(5000, 5000, vim.schedule_wrap(function()
	if vim.fn.mode():match("^[iR]") then
		return
	end

	pcall(vim.cmd, "silent! checktime")
end))
