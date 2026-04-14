local fzf = require("fzf-lua")

-- Перемещения по проекту
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Files" })
vim.keymap.set("n", "<leader>fg", fzf.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fs", fzf.live_grep, { desc = "Search text" })
vim.keymap.set("n", "<leader>fc", fzf.grep_curbuf, { desc = "Search current buffer" })
vim.keymap.set("n", "<leader>f.", fzf.resume, { desc = "Resume picker" })
-- Перемещения с использованием lsp
vim.keymap.set("n", "<leader>ls", fzf.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>lS", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>ld", fzf.diagnostics_document, { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>lD", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })

-- Переключение онлайн хинтов
vim.keymap.set("n", "<leader>lh", function()
    local enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not enabled)
end, { desc = "Toggle inlay hints (global)" })
