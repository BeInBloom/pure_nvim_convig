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

local lsp_format_priority = {
    "ruff",
    "lua_ls",
    "gopls",
    "rust-analyzer",
}

local formatters_by_ft = {}

for _, filetype in ipairs(prettier_filetypes) do
    formatters_by_ft[filetype] = { "prettier" }
end

local function get_lsp_format_client(bufnr)
    local clients = vim.lsp.get_clients({
        bufnr = bufnr,
        method = "textDocument/formatting",
    })

    if #clients == 0 then
        return nil
    end

    local clients_by_name = {}
    for _, client in ipairs(clients) do
        clients_by_name[client.name] = client
    end

    for _, name in ipairs(lsp_format_priority) do
        if clients_by_name[name] then
            return clients_by_name[name]
        end
    end

    table.sort(clients, function(left, right)
        return left.name < right.name
    end)

    return clients[1]
end

local function format_opts(bufnr)
    local client = get_lsp_format_client(bufnr)

    return {
        bufnr = bufnr,
        timeout_ms = 3000,
        lsp_format = "fallback",
        id = client and client.id,
    }
end

require("conform").setup({
    formatters_by_ft = formatters_by_ft,
    format_on_save = format_opts,
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
    require("conform").format(format_opts(vim.api.nvim_get_current_buf()))
end, {
    desc = "Format buffer",
})
