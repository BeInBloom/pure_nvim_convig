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

-- Python formats via the Ruff LSP instead of an external formatter.
local lsp_format_filetypes = {
    python = true,
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
        if lsp_format_filetypes[vim.bo[bufnr].filetype] then
            return {
                timeout_ms = 3000,
                lsp_format = "fallback",
            }
        end

        if not prettier_filetype_set[vim.bo[bufnr].filetype] then
            return
        end

        return {
            timeout_ms = 3000,
            lsp_format = "never",
        }
    end,
    formatters = {
        prettier = {
            prepend_args = function()
                local plugin = vim.fs.joinpath(
                    vim.fn.stdpath("data"),
                    "mason",
                    "packages",
                    "prettier",
                    "node_modules",
                    "prettier-plugin-svelte",
                    "plugin.js"
                )
                if vim.uv.fs_stat(plugin) then
                    return { "--plugin", plugin }
                end
                return {}
            end,
        },
    },
})

vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({
        timeout_ms = 1000,
        lsp_format = "fallback",
    })
end, {
    desc = "Format buffer",
})
