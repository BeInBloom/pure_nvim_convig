vim.pack.add({
    { src = "https://github.com/ibhagwan/fzf-lua" },
})

local actions = require("fzf-lua.actions")

require("fzf-lua").setup({
    "telescope",
    winopts = {
        backdrop = 85,
        preview = {
            default = "bat",
        },
    },
    keymap = {
        builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-p>"] = "toggle-preview",
        },
        fzf = {
            ["ctrl-a"] = "toggle-all",
            ["ctrl-t"] = "first",
            ["ctrl-g"] = "last",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
        },
    },
    actions = {
        files = {
            ["default"] = actions.file_edit_or_qf,
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-h"] = actions.toggle_hidden,
            ["ctrl-i"] = actions.toggle_ignore,
        },
    },
})
