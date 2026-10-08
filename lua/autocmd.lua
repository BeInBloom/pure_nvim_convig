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

-- Watch the directory rather than the file: many editors replace files by rename.
local file_watch_group = ag("ExternalFileReload", { clear = true })
local watcher, watched_buffer, watched_path
local check_scheduled = false

local function stop_watching()
	if watcher then
		watcher:stop()
		watcher:close()
		watcher = nil
	end
	watched_buffer, watched_path = nil, nil
	check_scheduled = false
end

local function check_current_file()
	local bufnr = vim.api.nvim_get_current_buf()
	if vim.bo[bufnr].buftype ~= "" or vim.api.nvim_buf_get_name(bufnr) == "" then
		return
	end
	-- Never replace unsaved edits with an externally changed version.
	if not vim.bo[bufnr].modified then
		vim.cmd("checktime " .. bufnr)
	end
end

local function watch_current_file()
	local bufnr = vim.api.nvim_get_current_buf()
	local name = vim.api.nvim_buf_get_name(bufnr)
	local path = name ~= "" and vim.fn.fnamemodify(name, ":p") or nil
	if watcher and bufnr == watched_buffer and path == watched_path then
		return
	end

	stop_watching()
	if not path or vim.bo[bufnr].buftype ~= "" then
		return
	end

	local fs_event = vim.uv.new_fs_event()
	if not fs_event then
		return
	end
	local real_path = vim.uv.fs_realpath(path) or path
	local basename = vim.fs.basename(real_path)
	-- Symlinked files never change inside the link's directory, so watch
	-- the resolved path's directory instead.
	local watch_dir = vim.fs.dirname(real_path)
	local ok = fs_event:start(watch_dir, {}, function(err, filename)
		if err or (filename and vim.fs.basename(filename) ~= basename) then
			return
		end
		if check_scheduled then
			return
		end
		check_scheduled = true
		vim.schedule(function()
			check_scheduled = false
			if watcher == fs_event and watched_path == path then
				check_current_file()
			end
		end)
	end)
	if not ok then
		fs_event:close()
		return
	end
	watcher, watched_buffer, watched_path = fs_event, bufnr, path
end

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "BufFilePost" }, {
	group = file_watch_group,
	callback = function()
		watch_current_file()
		check_current_file()
	end,
})

vim.api.nvim_create_autocmd("FocusGained", {
	group = file_watch_group,
	callback = check_current_file,
})

vim.api.nvim_create_autocmd("BufWipeout", {
	group = file_watch_group,
	callback = function(args)
		if args.buf == watched_buffer then
			stop_watching()
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = file_watch_group,
	callback = stop_watching,
})

watch_current_file()
