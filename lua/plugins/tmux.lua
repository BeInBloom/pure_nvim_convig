vim.pack.add({
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
})

vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>")
