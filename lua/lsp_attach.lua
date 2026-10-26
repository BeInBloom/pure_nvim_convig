local fzf = require("fzf-lua")

vim.diagnostic.config({
	virtual_text = true,
})

local lsp_augroup = vim.api.nvim_create_augroup("my_lsp_config", { clear = true })
local external_format_clients = {
	biome = true,
	cssls = true,
	eslint = true,
	html = true,
	svelte = true,
	ts_ls = true,
}

local function get_attached_client(args)
	local client_id = args.data and args.data.client_id
	return client_id and vim.lsp.get_client_by_id(client_id) or nil
end

local function apply_client_overrides(client)
	if client.name == "ruff" then
		client.server_capabilities.hoverProvider = false
	end

	if external_format_clients[client.name] then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
end

-- nowait: built-in global maps (grr, gri, gra, ...) would otherwise make
-- buffer-local "gr" wait 'timeoutlen' for a possible longer match.
local function map(bufnr, mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, nowait = true })
end

local function set_supported_keymaps(client, bufnr)
	local keymaps = {
		{ method = "textDocument/definition",     mode = "n", lhs = "gd",         rhs = vim.lsp.buf.definition,     desc = "Goto definition" },
		{ method = "textDocument/references",     mode = "n", lhs = "gr",         rhs = vim.lsp.buf.references,     desc = "References" },
		{ method = "textDocument/implementation", mode = "n", lhs = "gi",         rhs = vim.lsp.buf.implementation, desc = "Implementation" },
		{ method = "textDocument/hover",          mode = "n", lhs = "K",          rhs = vim.lsp.buf.hover,          desc = "Hover" },
		{ method = "textDocument/codeAction",     mode = "n", lhs = "<leader>la", rhs = vim.lsp.buf.code_action,    desc = "Code action" },
		{ method = "textDocument/rename",         mode = "n", lhs = "<leader>lr", rhs = vim.lsp.buf.rename,         desc = "Rename" },
		{ method = "textDocument/documentSymbol", mode = "n", lhs = "<leader>ls", rhs = fzf.lsp_document_symbols,   desc = "Document symbols" },
		{ method = "workspace/symbol",            mode = "n", lhs = "<leader>lS", rhs = fzf.lsp_workspace_symbols,  desc = "Workspace symbols" },
	}

	for _, keymap in ipairs(keymaps) do
		if client:supports_method(keymap.method, bufnr) then
			map(bufnr, keymap.mode, keymap.lhs, keymap.rhs, keymap.desc)
		end
	end
end

local function toggle_inlay_hints(bufnr)
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
end

local function setup_inlay_hints(client, bufnr)
	if not vim.lsp.inlay_hint then
		return
	end

	if not client:supports_method("textDocument/inlayHint", bufnr) then
		return
	end

	map(bufnr, "n", "<leader>lh", function()
		toggle_inlay_hints(bufnr)
	end, "Toggle inlay hints")
end

local function on_lsp_attach(args)
	local client = get_attached_client(args)

	if not client then
		return
	end

	local bufnr = args.buf

	apply_client_overrides(client)
	set_supported_keymaps(client, bufnr)
	setup_inlay_hints(client, bufnr)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_augroup,
	callback = on_lsp_attach,
})
