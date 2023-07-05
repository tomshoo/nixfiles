local conditions = require('config.lualine.conditions')
local components = {}

components.diff = {
    'diff',
    source = function()
        local diff = vim.b.gitsigns_status_dict
        return (diff and {
            added    = diff.added,
            removed  = diff.removed,
            modified = diff.changed,
        }) or nil
    end
}

components.lsp = {
    function()
        local names = {}

        for _, client in ipairs(vim.lsp.get_active_clients {
            bufnr = vim.fn.bufnr()
        }) do
            table.insert(
                names,
                string.len(client.name) <= 15 and client.name or "...")
        end

        return conditions.hide_in_width()
            and '[' .. table.concat(names, ':') .. ']'
            or string.format('[+%d]', #names)
    end,
    cond = conditions.lsp_is_active,
    icon = ' '
}

components.fileformat = {
    'fileformat',
    icons_enabled = false,
    fmt = string.upper,
}

components.mixed_indent = {
    function()
        local space_pat    = [[\v^ +]]
        local tab_pat      = [[\v^\t+]]
        local space_indent = vim.fn.search(space_pat, 'nwc')
        local tab_indent   = vim.fn.search(tab_pat, 'nwc')
        local mixed        = (space_indent > 0 and tab_indent > 0)
        local mixed_same_line

        if not mixed then
            mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
            mixed = mixed_same_line > 0
        end

        if not mixed then return '' end

        if mixed_same_line ~= nil and mixed_same_line > 0 then
            return 'MI:' .. mixed_same_line
        end

        local space_indent_cnt = vim.fn.searchcount({
            pattern = space_pat,
            max_count = 1e3
        }).total

        local tab_indent_cnt = vim.fn.searchcount({
            pattern = tab_pat,
            max_count = 1e3
        }).total

        if space_indent_cnt > tab_indent_cnt then
            return '' .. tab_indent
        else
            return '' .. space_indent
        end
    end,
    cond = function()
        return conditions.hide_in_width() and conditions.mode_isnt_insert()
    end
}

components.trailing_space = {
    function()
        local space = vim.fn.search([[\s\+$]], 'nwc')
        return (space ~= 0 and ' ' .. space)
            or ''
    end,
    cond = function()
        return conditions.hide_in_width() and conditions.mode_isnt_insert()
    end
}

components.filetype = {
    'filetype',
    icon = { align = 'right' },
}

components.window = function()
    return vim.api.nvim_win_get_number(0)
end

return components
