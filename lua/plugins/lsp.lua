vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
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
        "ruff",
        "pyrefly",
    },
    -- automatic_enable = {
    --     "lua_ls",
    --     "rust_analyzer",
    --     "ruff",
    --     "pyrefly",
    -- },
    automatic_enable = true,
})
