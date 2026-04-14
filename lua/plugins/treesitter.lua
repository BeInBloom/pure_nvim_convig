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
    },
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
