-- Core keymaps; plugin keymaps live next to their plugin in lua/plugins/.
local buffers = require("actions.buffers")

vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- diagnostics
-- [d / ]d are built-in since Neovim 0.11.
vim.keymap.set("n", "<leader>lg", vim.diagnostic.open_float, { desc = "Line diagnostics" })

vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })

-- buffer
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all buffers" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>wa<cr><cmd>qa<cr>", { desc = "Quit Neovim" })
vim.keymap.set("n", "<leader>q", buffers.close_current, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>c", "<cmd>close<cr>", { desc = "Close window" })
vim.keymap.set("n", "<leader>bc", buffers.close_others, { desc = "Close other buffers" })
vim.keymap.set("n", "|", "<C-w>v", { desc = "Vertical split" })
vim.keymap.set("n", "\\", "<C-w>s", { desc = "Horizontal split" })

-- tabs
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Delete tab" })
vim.keymap.set("n", "<leader>t]", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>t[", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
