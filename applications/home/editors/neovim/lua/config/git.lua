local M = {}

local wintype = (function()
    if vim.fn.exists('g:neovide') == 1 then
        return "floating"
    else
        return "split_above"
    end
end)()

local cfg = {
    kind = "tab",
    commit_popup = { kind = wintype },
    popup = { kind = wintype },
    sections = {
        untracked = {
            folded = false
        },
        unstaged = {
            folded = true
        },
        staged = {
            folded = true
        },
        stashes = {
            folded = true
        },
        unpulled = {
            folded = false
        },
        unmerged = {
            folded = true
        },
        recent = {
            folded = true
        },
    },
    signs = {
        section = { "+", "-" },
        item = { "+", "-" }
    }
}

function M.setup()
    local neogit = require('neogit')
    neogit.setup(cfg)
end

return M
