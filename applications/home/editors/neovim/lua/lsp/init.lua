local L_ = {}
L_.sumneko_lua = { settings = {
    Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim', 'typescript' } },
        telimitery = { enable = false }
    }
} }

L_.tsserver = { cmd = {
    typescript.tsserverPath,
    '--stdio',
    '--tsserver-path',
    typescript.typescriptLib
} }

L_.eslint = {
    settings = { codeActionOnSave = {
        enable = true,
        mode = "all"
    } },
    on_attach = function(client, ...)
        local _ = ...
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
    end
}

L_.nil_ls = {
    settings = { ['nil'] = {
        formatting = { command = { 'nixfmt' } }
    } }
}

L_.jedi_language_server = {}
L_.clangd = {}
L_.bashls = {}
L_.jsonls = {}
L_.cssls = {}
L_.vimls = {}
L_.html = {}
L_.gopls = {}

-- L_.haskell_language_server = {}


require('lsp.cmpconfig').setup()
local lspconfig = require('lspconfig')

for server, config in pairs(L_) do
    config.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    config.capabilities.textDocument.foldinRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    lspconfig[server].setup(config)
end

require('lsp.tools')
require('lsp.lightbulb')
require('lsp.symbols').setup()

vim.cmd [[
    highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
    highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
    highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
    highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]
