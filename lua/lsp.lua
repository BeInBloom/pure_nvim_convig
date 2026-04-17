local fzf = require("fzf-lua")

vim.diagnostic.config({
	virtual_text = true,
})

local lsp_augroup = vim.api.nvim_create_augroup("my_lsp_config", { clear = true })
local format_on_save_augroup = vim.api.nvim_create_augroup("my_lsp_format_on_save", { clear = true })
local format_priority = {
	"ruff",
	"lua_ls",
	"gopls",
	"rust_analyzer",
}
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

local function map(bufnr, mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
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

local function get_format_client(bufnr)
	local clients = vim.lsp.get_clients({
		bufnr = bufnr,
		method = "textDocument/formatting",
	})

	if #clients == 0 then
		return nil
	end

	local clients_by_name = {}
	for _, client in ipairs(clients) do
		clients_by_name[client.name] = client
	end

	for _, name in ipairs(format_priority) do
		local client = clients_by_name[name]
		if client then
			return client
		end
	end

	table.sort(clients, function(left, right)
		return left.name < right.name
	end)

	return clients[1]
end

local function format_buffer(bufnr)
	local client = get_format_client(bufnr)

	if not client then
		return
	end

	vim.lsp.buf.format({
		bufnr = bufnr,
		id = client.id,
		timeout_ms = 1000,
	})
end

local function setup_formatting(client, bufnr)
	if not client:supports_method("textDocument/formatting", bufnr) then
		return
	end

	map(bufnr, "n", "<leader>lf", function()
		format_buffer(bufnr)
	end, "Format buffer")

	if client:supports_method("textDocument/willSaveWaitUntil", bufnr) then
		return
	end

	vim.api.nvim_clear_autocmds({
		group = format_on_save_augroup,
		buffer = bufnr,
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = format_on_save_augroup,
		buffer = bufnr,
		callback = function()
			format_buffer(bufnr)
		end,
	})
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

	if vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

local function on_lsp_attach(args)
	local client = get_attached_client(args)

	if not client then
		return
	end

	local bufnr = args.buf

	apply_client_overrides(client)
	set_supported_keymaps(client, bufnr)
	setup_formatting(client, bufnr)
	setup_inlay_hints(client, bufnr)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_augroup,
	callback = on_lsp_attach,
})
