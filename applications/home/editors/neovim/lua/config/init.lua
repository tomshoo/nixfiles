_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache') .. '/luacache_chunk'
    },
    modpaths = {
        enabled = true,
        path = vim.fn.stdpath('cache') .. '/luacache_modpaths'
    }
}

require('impatient')
require('virt-column').setup({ char = '│' })

local function load_all()
    for _, plug in ipairs({
        'Comment',
        'gitsigns',
        'which-key',
        'toggleterm',
        'scrollbar',
        'nvim-surround',
        'scrollbar.handlers.search',
        'config.screenshot',
        'config.projects',
        'config.treesitter',
        'config.session',
        'config.telescope',
        -- 'config.lsp',
        'config.lsp_progress',
        'config.git',
        'config.autopairs',
        'config.nvimtree',
        'config.lualine',
        'config.bufferline',
        'config.dashboard',
        'config.indentguide',
        'config.trouble',
        -- 'config.wilder',
        'config.ufo',
        'config.clipboard',
        'config.tmux',
    }) do
        -- print(plug)
        require(plug).setup()
    end
end

-- Load everything
load_all()
