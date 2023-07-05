require 'lsp.completions'
require 'lsp.rust'
require 'lsp.null-ls'

local lspconfig = require 'lspconfig'
local signature = require 'lsp_signature'
local servers   = {}

require('fidget').setup {}

signature.setup {
    always_trigger = true,
    border         = 'none',
    hint_prefix    = '> ',
}

servers.lua_ls = {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            telimitery  = { enable = false },
        },
    }
}


servers.tsserver = {
    command = { { typescript.tsserverPath, "--stdio" } }
}


servers.clangd               = {}
servers.nil_ls               = {}
servers.jedi_language_server = {}

for server, config in pairs(servers) do
    config.capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    config.capabilities.textDocument.foldinRange = {
        dynamicRegistration = false,
        lineFoldingOnly     = true,
    }

    lspconfig[server].setup(config)
end


vim.api.nvim_create_autocmd({ "LspAttach" }, {
    group = vim.api.nvim_create_augroup('lspattach', { clear = true }),
    callback = function(args)
        local bufnr  = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        require('lsp_signature').on_attach(signature, bufnr)

        require 'lsp.highlight' (client, bufnr)
        require 'lsp.keymaps' (bufnr)

        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                group = vim.api.nvim_create_augroup('autoformat', { clear = true }),
                callback = function()
                    vim.lsp.buf.format({ async = vim.fn.has('g:async_formatting') == 1 or false })
                end
            })
        end
    end
})
