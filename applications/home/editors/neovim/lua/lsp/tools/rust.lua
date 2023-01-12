local M = {}

function M.mapper(bufnr)
    local rt = require('rust-tools')
    map("n", "<Leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
    map("n", "<Leader>e", rt.expand_macro.expand_macro,
        { buffer = bufnr, desc = "Expand macro under cursor" })
    return true
end

local tool = pcall(require, 'rust-tools')

function M.setup()
    require('rust-tools').setup {
        autoSetHints = true,
        server = {
            settings = { ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                    allTargets = false,
                },
                diagnostics = {
                    disabled = { "unresolved-import" }
                },
                cargo = {
                    loadOutDirsFromCheck = true
                }
            }
            }
        },
        tools = {
            parameter_hints_prefix = " <- ",
            other_hints_prefix = " => ",
            right_align = true
        }
    }
end

return M
