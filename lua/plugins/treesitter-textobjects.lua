vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
})

local select = require("nvim-treesitter-textobjects.select")

require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
        selection_modes = {
            ["@function.outer"] = "V",
            ["@class.outer"] = "V",
            ["@block.outer"] = "V",
            ["@conditional.outer"] = "V",
            ["@loop.outer"] = "V",
            ["@local.scope"] = "V",
        },
    },
})

local select_textobjects = {
    { lhs = "af", query = "@function.outer", desc = "Function outer" },
    { lhs = "if", query = "@function.inner", desc = "Function inner" },
    { lhs = "ac", query = "@class.outer", desc = "Class outer" },
    { lhs = "ic", query = "@class.inner", desc = "Class inner" },
    { lhs = "ab", query = "@block.outer", desc = "Block outer" },
    { lhs = "ib", query = "@block.inner", desc = "Block inner" },
    { lhs = "ai", query = "@conditional.outer", desc = "Conditional outer" },
    { lhs = "ii", query = "@conditional.inner", desc = "Conditional inner" },
    { lhs = "al", query = "@loop.outer", desc = "Loop outer" },
    { lhs = "il", query = "@loop.inner", desc = "Loop inner" },
    { lhs = "aa", query = "@attribute.outer", desc = "Attribute outer" },
    { lhs = "ia", query = "@attribute.inner", desc = "Attribute inner" },
    { lhs = "a=", query = "@assignment.outer", desc = "Assignment outer" },
    { lhs = "i=", query = "@assignment.inner", desc = "Assignment inner" },
    { lhs = "at", query = "@tag.outer", desc = "Tag outer" },
    { lhs = "it", query = "@tag.inner", desc = "Tag inner" },
    { lhs = "aS", query = "@local.scope", query_group = "locals", desc = "Scope" },
    { lhs = "iS", query = "@local.scope", query_group = "locals", desc = "Scope" },
}

local function set_select_keymaps(definitions)
    for _, definition in ipairs(definitions) do
        local query_group = definition.query_group or "textobjects"

        vim.keymap.set({ "x", "o" }, definition.lhs, function()
            select.select_textobject(definition.query, query_group)
        end, { desc = definition.desc })
    end
end

set_select_keymaps(select_textobjects)
