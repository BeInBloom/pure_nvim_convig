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

-- Neo-tree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem reveal left<cr>", { desc = "Neo-tree" })
vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus filesystem left<cr>", { desc = "Focus neo-tree" })

-- buffer
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all buffers" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>wa<cr><cmd>qa<cr>", { desc = "Quit Neovim" })
vim.keymap.set("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Навигация по окнам / tmux panes
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>")
