local cfg = {}

local nullls = require('null-ls')
local fmt = nullls.builtins.formatting
local diag = nullls.builtins.diagnostics

nullls.setup({ sources = {
    fmt.autopep8,
    fmt.nixfmt,
    fmt.prettier,
    fmt.eslint_d,
    diag.shellcheck,
    nullls.builtins.code_actions.eslint_d
} })

local formatter = require('lsp-format')

formatter.setup(cfg)
return formatter
