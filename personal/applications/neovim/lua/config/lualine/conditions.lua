local conditions = {}

conditions.buffer_not_empty = function()
    return not (vim.fn.line('$') == 1 and vim.fn.getline(1) == '')
end

conditions.hide_in_width = function()
    return vim.fn.winwidth(0) > 110
end

conditions.check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir   = vim.fn.finddir('.git', filepath .. ';')

    return gitdir and #gitdir > 0 and #gitdir < #filepath
end

conditions.lsp_is_active = function()
    local buf_ft  = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()

    if next(clients) == nil then
        return false
    end

    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return true
        end
    end

    return false
end

return conditions
