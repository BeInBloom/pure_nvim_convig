vim.pack.add({
	{ src = "https://github.com/edeneast/nightfox.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
	{ src = "https://github.com/sainnhe/everforest" },
	{ src = "https://github.com/sainnhe/gruvbox-material" },
	{ src = "https://github.com/craftzdog/solarized-osaka.nvim" },
})

require("nightfox").setup({
	options = {
		transparent = false,
		terminal_colors = true,
		dim_inactive = false,
		module_default = true,
		styles = {
			comments = "italic",
		},
	},
	groups = {
		all = {
			LineNr = { fg = "#57606a" },
			CursorLineNr = { fg = "#e5c07b", style = "bold" },

			BlinkCmpDoc = { bg = "#0f172a" },
			BlinkCmpDocBorder = { fg = "#334155", bg = "#0f172a" },
			BlinkCmpSignatureHelp = { bg = "#0f172a" },
			BlinkCmpSignatureHelpBorder = { fg = "#334155", bg = "#0f172a" },
		},
	},
})
