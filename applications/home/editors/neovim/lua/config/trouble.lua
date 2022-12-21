local M = {}

local cfg = {
    indent_lines = true,
    fold_closed = ">>+",
    signs = {
        error = "[error]",
        warning = "[warn]",
        hint = "[help]",
        information = "[info]"
    },
    use_diagnostic_signs = false
}

function M.setup()
    local trouble = require('trouble')

    trouble.setup(cfg)
end

return M
