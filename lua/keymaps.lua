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
vim.keymap.set("n", "<leader>ls", fzf.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>lS", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>ld", fzf.diagnostics_document, { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>lD", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Inlay hints
vim.keymap.set("n", "<leader>lh", function()
    local enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not enabled)
end, { desc = "Toggle inlay hints (global)" })

-- Neo-tree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem reveal left<cr>", { desc = "Neo-tree" })
vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus filesystem left<cr>", { desc = "Focus neo-tree" })

-- Quit / close buffer
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit Neovim" })
vim.keymap.set("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Навигация по окнам / tmux panes
vim.keymap.set("n", "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = "Left" })
vim.keymap.set("n", "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = "Down" })
vim.keymap.set("n", "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = "Up" })
vim.keymap.set("n", "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = "Right" })
