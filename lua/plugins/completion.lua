vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },

    signature = {
        enabled = true,
        window = {
            border = "rounded",
            scrollbar = false,
            max_width = 80,
            max_height = 12,
        },
    },

    keymap = {
        preset = "default",
        ["<C-Space>"] = {},
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<M-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "hide" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        menu = {
            border = "rounded",
            scrollbar = false,
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
                border = "rounded",
                scrollbar = false,
                max_width = 80,
                max_height = 16,
            },
        },
    },

    cmdline = {
        keymap = {
            preset = "inherit",
            ["<CR>"] = { "accept_and_enter", "fallback" },
        },
    },

    sources = {
        default = { "lsp", "path" },
    },
})
