vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("gitsigns").setup({
	signcolumn = true,
	numhl = false,
	linehl = false,
	current_line_blame = false,
	attach_to_untracked = false,
})

vim.keymap.set("n", "<leader>gw", "<cmd>Gitsigns toggle_word_diff<cr>", {
	desc = "Toggle git word diff",
})
