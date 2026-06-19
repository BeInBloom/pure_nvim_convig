vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
})

require("which-key").setup({
	preset = "classic",
	delay = 300,
	triggers = {
		{ "<leader>", mode = { "n", "v" } },
	},
	icons = {
		mappings = false,
	},
	win = {
		border = "rounded",
	},
	disable = {
		ft = { "neo-tree" },
	},
})
