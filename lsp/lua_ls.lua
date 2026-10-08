local root_markers = {
	{ ".luarc.json", ".luarc.jsonc", ".emmyrc.json" },
	{ ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
	{ ".git" },
}

return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = function(bufnr, on_dir)
		local filename = vim.api.nvim_buf_get_name(bufnr)
		on_dir(vim.fs.root(filename, root_markers) or vim.fs.dirname(filename))
	end,
	settings = {
		Lua = {
			completion = {
				enable = true,
			},
			diagnostics = {
				enable = true,
				globals = { "vim" },
			},
			workspace = {
				library = { vim.env.VIMRUNTIME },
				checkThirdParty = false,
			},
		},
	},
}
