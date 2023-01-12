local mappers   = {
    require('lsp.tools.rust').mapper,
    require('lsp.mappings'),
}
local highlight = require('lsp.highlight_symbol')
local sign      = require('lsp.signatures')
local fmt       = require('lsp.formatter')

local ignoreFormatter = {
    "tsserver",
    "jsonls",
}

local function client_on_attach(args)
    local bufnr  = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if sign then
        require('lsp_signature').on_attach(sign, bufnr)
    end

    if vim.tbl_contains(ignoreFormatter, client.name) then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    if fmt then
        fmt.on_attach(client, bufnr)
    end
    highlight(client, bufnr)

    for _, mapper in ipairs(mappers) do
        mapper()
    end
end

local lspattach = vim.api.nvim_create_augroup("LspAttack", { clear = true })
vim.api.nvim_create_autocmd({ "LspAttach" }, {
    group = lspattach,
    callback = client_on_attach
})
