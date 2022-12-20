_G.version = vim.version()

vim.cmd.colorscheme "onedark"

vim.cmd [[]]

vim.opt.undofile   = true
vim.opt.wrap       = false
vim.opt.wildmode   = "list:longest:full"
vim.opt.signcolumn = "yes:2"

vim.opt.fillchars:append("stlnc:·")

vim.opt.rtp:append(os.getenv("HOME") .. "/.config/nvim/")

vim.opt.guicursor = "r-v-c-sm:block,i-ci-ve:ver25,cr-o:hor21,n:hor10"

vim.opt.list = true
vim.opt.listchars:append({
    eol   = "⏎",
    tab   = "␉·",
    trail = "␠",
    nbsp  = "⎵",
})

vim.opt.ruler = true
vim.opt.list  = true

vim.opt.title       = true
vim.opt.showmode    = true
vim.opt.tabstop     = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.expandtab   = true
vim.opt.shiftwidth  = 4
vim.opt.ignorecase  = true
vim.opt.hidden      = true
vim.opt.wildmenu    = true
vim.opt.scrolloff   = 8

vim.g.colorizer_startup = 1

-- For Conceal markers
if vim.fn.has('conceal')
then
    vim.opt.conceallevel  = 2
    vim.opt.concealcursor = "nvc"
end

-- Set cursorhold update time to a larger value to not make things messed up
vim.g.cursorhold_updatetime = 100
