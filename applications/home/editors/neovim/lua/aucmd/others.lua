vim.api.nvim_create_augroup('SiliconRefresh', { clear = true })
vim.api.nvim_create_autocmd({ 'ColorScheme' },
    {
        group = 'SiliconRefresh',
        callback = function()
            local silicon_utils = require('silicon.utils')
            silicon_utils.build_tmTheme()
            silicon_utils.reload_silicon_cache({ async = true })
        end,
        desc = 'Reload silicon themes cache on colorscheme switch',
    }
)
