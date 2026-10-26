local function rust_lsp(...)
	local args = { ... }
	return function()
		vim.cmd.RustLsp(args)
	end
end

local function on_attach(_, bufnr)
	-- Runs after LspAttach, so these override the generic K and <leader>la.
	local function map(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
	end

	map("K", rust_lsp("hover", "actions"), "Hover actions")
	map("<leader>la", rust_lsp("codeAction"), "Code action")
	map("<leader>le", rust_lsp("explainError", "current"), "Explain error")
	map("<leader>lE", rust_lsp("renderDiagnostic", "current"), "Render diagnostic")

	map("<leader>rr", function()
		vim.cmd.RustLsp({ "runnables", bang = true })
	end, "Rerun last runnable")
	map("<leader>rR", rust_lsp("runnables"), "Runnables")
	map("<leader>rt", rust_lsp("testables"), "Testables")
	map("<leader>rm", rust_lsp("expandMacro"), "Expand macro")
	map("<leader>rc", rust_lsp("openCargo"), "Open Cargo.toml")
	map("<leader>rd", rust_lsp("openDocs"), "Open docs.rs")
	map("<leader>rp", rust_lsp("parentModule"), "Parent module")
	map("<leader>dn", rust_lsp("debug"), "Debug at cursor")
end

-- Must be set before the plugin is loaded.
vim.g.rustaceanvim = {
	server = {
		on_attach = on_attach,
		-- No check override: rustaceanvim defaults to clippy with --no-deps.
		default_settings = {
			["rust-analyzer"] = {
				inlayHints = {
					typeHints = { enable = true },
					parameterHints = { enable = true },
					chainingHints = { enable = true },
				},
			},
		},
	},
}

vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },
})
