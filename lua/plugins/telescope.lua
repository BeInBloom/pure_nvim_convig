vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
})

require("telescope").setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({
                previewer = false,
                layout_config = {
                    width = 0.5,
                    height = 0.4,
                },
            }),
        },
    },
})

require("telescope").load_extension("ui-select")
