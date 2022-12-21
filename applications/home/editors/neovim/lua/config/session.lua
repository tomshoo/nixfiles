local M = {}

local cfg = {
    auto_session_enable_last_session = false,
    auto_restore_enabled = false
}

function M.setup()
    local session = require("auto-session")
    session.setup(cfg)
end

return M
