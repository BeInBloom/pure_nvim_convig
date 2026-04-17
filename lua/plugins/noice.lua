vim.pack.add({
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/folke/noice.nvim" },
})

local function hover_size()
	return {
		width = "auto",
		height = "auto",
		max_width = math.max(45, math.min(90, math.floor(vim.o.columns * 0.55))),
		max_height = math.max(8, math.min(20, math.floor(vim.o.lines * 0.35))),
	}
end

local function update_hover_size()
	local ok, config = pcall(require, "noice.config")

	if not ok then
		return
	end

	config.options.views.hover.size = hover_size()
end

require("noice").setup({
	timeout = 2000,
	stages = 'static',
	lsp = {
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
			filter = {
				event = "notify",
				["not"] = { error = true },
			},
			opts = { skip = true },
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

vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("DynamicNoiceHoverSize", { clear = true }),
	callback = update_hover_size,
})
