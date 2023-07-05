local components = require('config.lualine.components')

local help = {
    options = {
        theme = "auto",
    },
    filetypes = { 'help' },
    sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'searchcount' },
    }
}

require('lualine').setup {
    options = {
        section_separators   = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
    },
    sections = {
        lualine_a = { components.window, 'mode' },
        lualine_b = { 'branch', components.diff, 'diagnostics' },
        lualine_c = { components.lsp, '%=', 'filename' },
        lualine_x = { 'encoding', components.fileformat, components.filetype },
        lualine_y = { 'progress', components.mixed_indent, components.trailing_space },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },

    extension = { help },
}
