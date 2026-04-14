vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
})

require("nvim-web-devicons").setup({
    default = true,
})

local function lsp_clients()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    if #clients == 0 then
        return "No LSP"
    end

    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end
    table.sort(names)

    return table.concat(names, ", ")
end

require("lualine").setup({
    options = {
        theme = "auto",
        globalstatus = true,
    },
    sections = {
        lualine_x = {
            "diagnostics",
            lsp_clients,
            "encoding",
            "fileformat",
            "filetype",
        },
    },
})
