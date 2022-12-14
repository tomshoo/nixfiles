local M = {}

local cfg = {
    pickers = {
        find_files      = { theme = "dropdown", previewer = false },
        buffers         = { theme = "dropdown", previewer = false },
        builtin         = { theme = "dropdown" },
        lsp_definitions = { theme = "ivy" },
        lsp_references  = { theme = "cursor", previewer = false },
    },
    extensions = {
        ['ui-select'] = { require('telescope.themes').get_cursor() },
        frecency      = {
            ignore_patterns  = { '*.git/*', '*/tmp/*', '*cache**' },
            disable_devicons = false,
            show_unindexed   = false
        }
    }
}

function M.setup()
    local telescope = require('telescope')

    telescope.setup(cfg)
    telescope.load_extension('ui-select')
    telescope.load_extension('session-lens')
    telescope.load_extension('frecency')
    telescope.load_extension('projects')
end

return M
