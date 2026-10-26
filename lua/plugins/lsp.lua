vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- ts_ls and svelte otherwise use Neovim's cwd when no project root exists,
-- which can point to an unrelated project when opening a standalone file.
local js_project_markers = {
	"package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", "deno.lock", ".git",
}

for _, name in ipairs({ "ts_ls", "svelte" }) do
	local original_root_dir = vim.lsp.config[name].root_dir
	vim.lsp.config(name, {
		root_dir = function(bufnr, on_dir)
			original_root_dir(bufnr, function(root)
				if root == vim.fn.getcwd() and not vim.fs.root(bufnr, js_project_markers) then
					root = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
				end
				on_dir(root)
			end)
		end,
	})
end

-- tailwindcss ships elixir filetypes (elixir, eelixir, heex, html-eex) and a
-- '.git' root_dir fallback, so it attaches to every elixir buffer in a git
-- repo. Strip the elixir-related filetypes so only elixirls serves them
-- (this also stops double hover results on K).
local tailwind_filetypes = vim.list_extend({}, vim.lsp.config.tailwindcss.filetypes)
local elixir_filetypes = { elixir = true, eelixir = true, heex = true, ["html-eex"] = true }
tailwind_filetypes = vim.tbl_filter(function(ft)
	return not elixir_filetypes[ft]
end, tailwind_filetypes)

vim.lsp.config("tailwindcss", {
	filetypes = tailwind_filetypes,
})

require("mason").setup({
	PATH = "prepend",
	max_concurrent_installers = 4,
	ui = {
		check_outdated_packages_on_open = true,
		border = "rounded",
		width = 0.8,
		height = 0.9,
		backdrop = 60,
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"zls",
		"elixirls",
		"clojure_lsp",
		"ruff",
		"pyrefly",
		"html",
		"cssls",
		"tailwindcss",
		"ts_ls",
		"svelte",
		"eslint",
	},
	-- rust-analyzer is run by rustaceanvim (lua/plugins/rust.lua).
	automatic_enable = { exclude = { "rust_analyzer" } },
})
