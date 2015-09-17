filetype indent plugin on     " Attempt to determine the type of a file
syntax on                     " Enable syntax highlighting

set ignorecase                " Use case insensitive search, except when using capital letters
set smartcase

set cmdheight=2               " Set the command window height to 2 lines
set number                    " Display line numbers on the left
set listchars=tab:>-,trail:-
set list

set guioptions-=L             " turns the scrollbar off in gvim
let g:netrw_mousemaps = 0     " disables the mouse from selecting files
let g:netrw_altv = 1          " create new vertical windows on the left
let g:netrw_banner = 1        " disables the annoying banner
let g:netrw_liststyle = 4     " use the tree list by default
let g:netrw_browse_split = 4  " when opening a file from the browser, open in preivous pane

nmap <silent> <C-A> :25 Vexplore<CR>  " keybinding to open file browser in left pane
