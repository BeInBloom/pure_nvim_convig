vim.pack.add({
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/folke/noice.nvim" },
})

require("notify").setup({
	stages = "static",
	timeout = 2000,
})

local function clamp(value, min, max)
	max = math.max(1, max)
	min = math.min(min, max)

	return math.max(min, math.min(max, value))
end

local function hover_size()
	local win_width = vim.api.nvim_win_get_width(0)
	local win_height = vim.api.nvim_win_get_height(0)

	local cursor_row = vim.fn.winline()

	local space_above = cursor_row - 3
	local space_below = win_height - cursor_row - 3

	local available_height = math.max(space_above, space_below)

	return {
		width = "auto",
		height = "auto",

		max_width = clamp(
			math.floor(win_width * 0.85),
			30,
			win_width - 4
		),

		max_height = clamp(
			math.floor(available_height * 0.9),
			6,
			math.min(16, win_height - 4)
		),
	}
end

local function update_hover_size()
	local ok, config = pcall(require, "noice.config")

	if not ok then
		return
	end

	if config.options.views and config.options.views.hover then
		config.options.views.hover.size = hover_size()
	end
end

require("noice").setup({
	lsp = {
		signature = {
			enabled = false,
		},

		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},

	views = {
		hover = {
			size = hover_size(),
		},
	},

	routes = {
		{
			view = "cmdline_output",
			filter = { cmdline = "^:%s*!" },
		},
	},

	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = true,
		lsp_doc_border = true,
	},
})

vim.api.nvim_create_autocmd({
	"VimResized",
	"WinResized",
	"WinEnter",
	"BufWinEnter",
	"CursorMoved",
	"CursorMovedI",
}, {
	group = vim.api.nvim_create_augroup("DynamicNoiceHoverSize", {
		clear = true,
	}),
	callback = update_hover_size,
})
