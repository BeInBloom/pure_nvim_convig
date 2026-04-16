vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
})

require("neo-tree").setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,

    filesystem = {
        hijack_netrw_behavior = "open_current",
        follow_current_file = {
            enabled = true,
        },
        filtered_items = {
            visible = true,
            hide_dotfiles = true,
            hide_gitignored = true,
        },
    },

    window = {
        width = 32,
        mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
            ["H"] = "toggle_hidden",
            ["z"] = "toggle_node",
            ["Y"] = "copy_path",
            ["/"] = "noop",
        },
    },
})
