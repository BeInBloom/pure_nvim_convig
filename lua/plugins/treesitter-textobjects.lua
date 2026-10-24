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
    -- Not ab/ib: those are the built-in a(/i( objects.
    { lhs = "ao", query = "@block.outer", desc = "Block outer" },
    { lhs = "io", query = "@block.inner", desc = "Block inner" },
    { lhs = "ai", query = "@conditional.outer", desc = "Conditional outer" },
    { lhs = "ii", query = "@conditional.inner", desc = "Conditional inner" },
    { lhs = "al", query = "@loop.outer", desc = "Loop outer" },
    { lhs = "il", query = "@loop.inner", desc = "Loop inner" },
    { lhs = "aa", query = "@parameter.outer", desc = "Argument/parameter outer" },
    { lhs = "ia", query = "@parameter.inner", desc = "Argument/parameter inner" },
    { lhs = "aA", query = "@attribute.outer", desc = "Attribute outer" },
    { lhs = "iA", query = "@attribute.inner", desc = "Attribute inner" },
    { lhs = "a=", query = "@assignment.outer", desc = "Assignment outer" },
    { lhs = "i=", query = "@assignment.inner", desc = "Assignment inner" },
    { lhs = "aS", query = "@local.scope", query_group = "locals", desc = "Scope" },
    { lhs = "iS", query = "@local.scope", query_group = "locals", desc = "Scope" },
}

local tag_textobjects = {
    { lhs = "at", query = "@tag.outer", desc = "Tag outer" },
    { lhs = "it", query = "@tag.inner", desc = "Tag inner" },
}

local function set_select_keymaps(definitions, bufnr)
    for _, definition in ipairs(definitions) do
        local query_group = definition.query_group or "textobjects"

        vim.keymap.set({ "x", "o" }, definition.lhs, function()
            select.select_textobject(definition.query, query_group)
        end, { buffer = bufnr, desc = definition.desc })
    end
end

set_select_keymaps(select_textobjects)

local function has_textobject(lang, capture)
    local ok, query = pcall(vim.treesitter.query.get, lang, "textobjects")
    return ok and query ~= nil and vim.list_contains(query.captures, capture)
end

-- Built-in at/it work in any filetype; replace them only where a textobjects
-- query defines @tag (html, jsx/tsx, svelte, vue, heex).
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("my_tag_textobjects", { clear = true }),
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang and has_textobject(lang, "tag.outer") then
            set_select_keymaps(tag_textobjects, args.buf)
        end
    end,
})
