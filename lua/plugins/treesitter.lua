vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local ts = require("nvim-treesitter")

ts.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

ts.install({
    "vim",
    "regex",
    "lua",
    "bash",
    "markdown",
    "markdown_inline",
    "go",
    "rust",
    "python",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "vue",
    "heex",
    "svelte",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "lua",
        "vim",
        "markdown",
        "python",
        "rust",
        "go",
        "sh",
        "bash",
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "tsx",
        "vue",
        "heex",
        "svelte",
    },
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
