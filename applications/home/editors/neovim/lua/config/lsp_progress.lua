local M = {}

local cfg = {
    text = {
        spinner = {
            [=[[~][=>  ] ]=],
            [=[[\][==> ] ]=],
            [=[[|][===>] ]=],
            [=[[/][====] ]=],
            [=[[~][>===] ]=],
            [=[[\][ >==] ]=],
            [=[[|][  >=] ]=],
            [=[[/][  <=] ]=],
            [=[[~][ <==] ]=],
            [=[[\][<===] ]=],
            [=[[|][====] ]=],
            [=[[/][===<] ]=],
            [=[[~][==< ] ]=],
            [=[[ ][=<  ] ]=],
        }
    },
    window = {
        border = "none"
    },
    sources = {
        ['null-ls'] = { ignore = true }
    }
}

function M.setup()
    local fidget = require('fidget')
    fidget.setup(cfg)
end

return M
