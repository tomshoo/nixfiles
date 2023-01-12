local cfg = {
    always_trigger = true,
    border = "rounded",
    hint_prefix = "-> "
}

return require('lsp_signature').setup(cfg)
