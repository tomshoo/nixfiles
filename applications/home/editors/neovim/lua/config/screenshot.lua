local M = {}

local screenshot_path = os.getenv("HOME") .. "/Pictures/Silicon/"

if not vim.fn.isdirectory(screenshot_path) then
    vim.fn.mkdir(screenshot_path)
end

function M.setup()
    local silicon = require("silicon")

    silicon.setup({
        output = screenshot_path ..
            "Screenshot from ${year}-${month}-${date} ${time}.png",
        lineNumber = false,
    })

    -- Generate image of lines in a visual selection
    map('v', '<Leader><C-s>', function() silicon.visualise_api({}) end)
    -- Generate image of a whole buffer, with lines in a visual selection highlighted
    map('v', '<Leader>b<C-s>', function() silicon.visualise_api({ to_clip = true, show_buf = true }) end)
    -- Generate visible portion of a buffer
    map('n', '<Leader><C-s>', function() silicon.visualise_api({ visible = true }) end)
    -- Generate current buffer line in normal mode
    map('n', '<Leader>b<C-s>', function() silicon.visualise_api({ show_buf = true, visible = true }) end)
end

return M
