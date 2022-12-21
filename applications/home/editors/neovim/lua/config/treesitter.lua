local M = {}

local config = {
    yati = { enable = true },
    sync_install = false,
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ib"] = "@block.inner",
                ["ab"] = "@block.outer"
            }
        }
    },
    rainbow = {
        enable = true,
        extend_mode = true,
        colors = {
            "#67b0e8",
            "#6cbfbf",
            "#8ccf7e",
            "#e5c76b",
            "#e57474"
        }
    }
}

local tsccfg = {
}

function M.setup()
    require('nvim-treesitter.configs').setup(config)
    require('treesitter-context').setup(tsccfg)
end

return M
