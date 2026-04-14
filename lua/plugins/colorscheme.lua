vim.pack.add({
    { src = "https://github.com/edeneast/nightfox.nvim" },
})

require("nightfox").setup({
    options = {
        transparent = false,
        terminal_colors = true,
        dim_inactive = false,
        module_default = true,
        styles = {
            comments = "italic",
        },
    },
    groups = {
        all = {
            LineNr = { fg = "#57606a" },
            CursorLineNr = { fg = "#e5c07b", style = "bold" },

            BlinkCmpDoc = { bg = "#0f172a" },
            BlinkCmpDocBorder = { fg = "#334155", bg = "#0f172a" },
            BlinkCmpSignatureHelp = { bg = "#0f172a" },
            BlinkCmpSignatureHelpBorder = { fg = "#334155", bg = "#0f172a" },
        },
    },
})
