local M = {}

function M.close_current()
	local current = vim.api.nvim_get_current_buf()

	if vim.bo[current].modified then
		vim.notify("No write since last change", vim.log.levels.WARN)
		return
	end

	-- Special buffers (help, neo-tree, dashboard, terminal) are not part of the
	-- buffer list: close their window instead of loading a file into it.
	if vim.bo[current].buftype ~= "" or not vim.bo[current].buflisted then
		if not pcall(vim.cmd.close) then
			local ok, err = pcall(vim.api.nvim_buf_delete, current, {})
			if not ok then
				vim.notify(err, vim.log.levels.ERROR)
			end
		end
		return
	end

	local alternate = vim.fn.bufnr("#")
	if alternate > 0 and alternate ~= current and vim.api.nvim_buf_is_valid(alternate) and vim.bo[alternate].buflisted then
		vim.cmd("buffer " .. alternate)
	else
		local next_buffer = nil

		for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
			if buffer ~= current and vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buflisted then
				next_buffer = buffer
				break
			end
		end

		if next_buffer then
			vim.cmd("buffer " .. next_buffer)
		else
			vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, false))
		end
	end

	local ok, err = pcall(vim.api.nvim_buf_delete, current, {})
	if not ok then
		vim.notify(err, vim.log.levels.ERROR)
	end
end

function M.close_others()
	local current = vim.api.nvim_get_current_buf()

	-- Buffers shown in other windows are kept: :bdelete would close those splits.
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
			if vim.bo[buf].buftype == "" and not vim.bo[buf].modified and #vim.fn.win_findbuf(buf) == 0 then
				vim.cmd("bdelete " .. buf)
			end
		end
	end
end

return M
