vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
})

vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
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
        "rust_analyzer",
        "gopls",
        "ruff",
        "pyrefly",
        "html",
        "cssls",
        "tailwindcss",
        "ts_ls",
        "svelte",
        "eslint",
    },
    automatic_enable = true,
})
