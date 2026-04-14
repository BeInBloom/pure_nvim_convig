vim.pack.add({
    { src = "https://github.com/windwp/nvim-autopairs" },
})

require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
    check_ts = true,
    map_cr = true,
    map_bs = true,
    enable_check_bracket_line = true,
    fast_wrap = {},
})
