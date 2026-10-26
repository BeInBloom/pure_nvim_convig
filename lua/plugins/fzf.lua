vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

local fzf = require("fzf-lua")
local actions = require("fzf-lua.actions")

fzf.setup({
	"telescope",
	fzf_colors = true,
	winopts = { backdrop = 85 },
	ui_select = {
		winopts = { width = 0.5, height = 0.4 },
	},
	keymap = {
		builtin = {
			["<C-f>"] = "preview-page-down",
			["<C-b>"] = "preview-page-up",
			["<C-p>"] = "toggle-preview",
		},
		fzf = {
			["ctrl-a"] = "toggle-all",
			["ctrl-t"] = "first",
			["ctrl-g"] = "last",
			["ctrl-d"] = "half-page-down",
			["ctrl-u"] = "half-page-up",
		},
	},
	actions = {
		files = {
			["default"] = actions.file_edit_or_qf,
			["ctrl-q"] = actions.file_sel_to_qf,
			["ctrl-h"] = actions.toggle_hidden,
			["ctrl-i"] = actions.toggle_ignore,
		},
	},
})

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Files" })
vim.keymap.set("n", "<leader>fg", fzf.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fp", fzf.grep_project, { desc = "Search project lines" })
vim.keymap.set("n", "<leader>ft", fzf.live_grep, { desc = "Search text" })
vim.keymap.set("n", "<leader>fc", fzf.grep_curbuf, { desc = "Search current buffer" })
vim.keymap.set("n", "<leader>f.", fzf.resume, { desc = "Resume picker" })

vim.keymap.set("n", "<leader>ld", fzf.diagnostics_document, { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>lD", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })
