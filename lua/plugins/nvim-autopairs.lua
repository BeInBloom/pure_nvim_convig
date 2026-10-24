vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs" },
})

require("nvim-autopairs").setup({
	check_ts = true,
	map_cr = true,
	map_bs = true,
	enable_check_bracket_line = true,
	fast_wrap = {},
})
