local M = {}

local cfg = {}

function M.setup()
    local tmux = require('tmux')

    tmux.setup(cfg)
    map("n", "<C-M>h", tmux.resize_left)
    map("n", "<C-M>j", tmux.resize_bottom)
    map("n", "<C-M>k", tmux.resize_top)
    map("n", "<C-M>l", tmux.resize_right)
    return true
end

return M
