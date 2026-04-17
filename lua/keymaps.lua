-- lua/keymaps.lua
local fzf = require("fzf-lua")

-- Поиск / проект
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Files" })
vim.keymap.set("n", "<leader>fg", fzf.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fs", fzf.live_grep, { desc = "Search text" })
vim.keymap.set("n", "<leader>fc", fzf.grep_curbuf, { desc = "Search current buffer" })
vim.keymap.set("n", "<leader>f.", fzf.resume, { desc = "Resume picker" })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- LSP / symbols / diagnostics
vim.keymap.set("n", "<leader>ld", fzf.diagnostics_document, { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>lD", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })

vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Line diagnostics" })

vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })

-- Neo-tree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem reveal left<cr>", { desc = "Neo-tree" })
vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus filesystem left<cr>", { desc = "Focus neo-tree" })

-- buffer
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all buffers" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>wa<cr><cmd>qa<cr>", { desc = "Quit Neovim" })
vim.keymap.set("n", "<leader>q", "<cmd>bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>c", "<C-w>c", { desc = "Close window" })
vim.keymap.set("n", "<leader>bc", function()
	local current = vim.api.nvim_get_current_buf()

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
			if vim.bo[buf].buftype == "" and not vim.bo[buf].modified then
				vim.cmd("bdelete " .. buf)
			end
		end
	end
end, { desc = "Close other buffers" })

-- tabs
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Delete tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Навигация по окнам / tmux panes
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>")
