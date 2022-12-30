local mappers   = {
    require('config.lsp.tools.rust').mapper,
    require('config.lsp.mappings'),
}
local highlight = require('config.lsp.highlight_symbol')
local sign      = require('config.lsp.signatures').setup()
local fmt       = require('config.lsp.formatter').setup()
local M         = {}

local ignoreFormatter = {
    "tsserver",
}

local function find(tbl, key)
    for _, property in ipairs(tbl) do
        if key == property then
            return true
        end
    end

    return false
end

function M.setup()
    local lspattach = vim.api.nvim_create_augroup("LspAttack", { clear = true })
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
        group = lspattach,
        callback = function(args)
            local bufnr  = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if sign then
                require('lsp_signature').on_attach(sign, bufnr)
            end

            if find(ignoreFormatter, client.name) then
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end

            if fmt then
                fmt.on_attach(client, bufnr)
            end
            highlight.setup(client, bufnr)

            for _, mapper in ipairs(mappers) do
                mapper()
            end
        end
    })
end

return M
