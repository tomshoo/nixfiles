cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))

" Configure backup and undo thingies
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "pset")
endif

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

let g:undotree_WindowLayout = 2

autocmd! FileType toggleterm set colorcolumn=
autocmd! CursorHold * TSDisable rainbow | TSEnable rainbow " 'fixes' a bug with `nvim-ts-rainbow

augroup NumberToggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set nornu | endif
augroup END

augroup SetCursorline
    autocmd!
    autocmd InsertEnter,BufLeave,WinLeave * if &cursorline | set nocursorline | endif
    autocmd InsertLeave,BufEnter,WinEnter * set cursorline
augroup END
