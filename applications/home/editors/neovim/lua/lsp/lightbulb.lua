local cfg = {
    status_text = {
        enabled = true
    },
    autocmd = {
        enabled = true,
        pattern = { '*' },
        events = { 'CursorHold', 'CursorHoldI' }
    }
}

require('nvim-lightbulb').setup(cfg)
