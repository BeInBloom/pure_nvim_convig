vim.diagnostic.config({
    virtual_text = true,
})

local lsp_augroup = vim.api.nvim_create_augroup("my_lsp_config", { clear = true })

local function on_lsp_attach(args)
    if vim.lsp.inlay_hint and vim.lsp.inlay_hint.is_enabled() then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_augroup,
    callback = on_lsp_attach,
})
