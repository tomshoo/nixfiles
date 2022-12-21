local M = {}

local cfg = {
    detection_methods = { 'pattern' },
    patterns = {
        ">Projects",
        "!=nvim",
        ".git",
        "Makefile",
        "Cargo.toml",
        "*setup*"
    },
    exclude_dirs = {
        "~/.local/share/nvim/*",
        "~/.cargo/*"
    },
    scope_chdir = 'tab'
}

function M.setup()
    local projects = require('project_nvim')
    projects.setup(cfg)
end

return M
