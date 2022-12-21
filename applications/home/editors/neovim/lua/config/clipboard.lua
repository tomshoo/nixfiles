local M = {}

local cfg = {
    history = 30,
}

M.setup = function()
    local clip = require('neoclip')
    clip.setup(cfg)
    return true
end

return M
