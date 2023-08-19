return function(bufnr)
    map('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = bufnr })
    map('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })

    map('n', ';r', vim.lsp.buf.rename, { buffer = bufnr })
    map('n', ';a', vim.lsp.buf.code_action, { buffer = bufnr })
    map('n', ';t', "<cmd>TroubleToggle document_diagnostics<cr>", { buffer = bufnr })
    map('n', ';T', "<cmd>TroubleToggle workspace_diagnostics<cr>", { buffer = bufnr })
end
