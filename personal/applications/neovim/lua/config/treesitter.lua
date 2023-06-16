local tsitter = require 'nvim-treesitter.configs'
local tsctxt  = require 'treesitter-context'

tsctxt.setup {}

tsitter.setup {
    highlight = {
        enable = true,
    },
    textobjects = { ['select'] = {
        enable = true,
        lookahead = true,
    } },
}
