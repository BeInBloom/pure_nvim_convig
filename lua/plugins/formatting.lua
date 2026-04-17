vim.pack.add({
    "https://github.com/stevearc/conform.nvim",
})

local prettier_filetypes = {
    "html",
    "css",
    "scss",
    "less",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "svelte",
}

local formatters_by_ft = {}
local prettier_filetype_set = {}

for _, filetype in ipairs(prettier_filetypes) do
    formatters_by_ft[filetype] = { "prettier" }
    prettier_filetype_set[filetype] = true
end

require("conform").setup({
    formatters_by_ft = formatters_by_ft,
    format_after_save = function(bufnr)
        if not prettier_filetype_set[vim.bo[bufnr].filetype] then
            return
        end

        return {
            timeout_ms = 3000,
            lsp_format = "never",
        }
    end,
})

vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({
        timeout_ms = 1000,
        lsp_format = "fallback",
    })
end, {
    desc = "Format buffer",
})
