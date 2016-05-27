set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'   " Let Vundle manage Vundle, required
Plugin 'vhda/verilog_systemverilog.vim'  " Verilog plugin
Plugin 'derekwyatt/vim-scala'  " Scala syntax highlighting

call vundle#end()
filetype plugin indent on

syntax on                   " Enable syntax highlighting

set ignorecase              " Use case insensitive search, except when using capital letters
set smartcase
set tabstop=4

set cmdheight=2             " Set the command window height to 2 lines
set number                  " Display line numbers on the left

set guioptions-=L           " turns the scrollbar off in gvim
let g:netrw_mousemaps = 0
let g:netrw_altv = 1
let g:netrw_banner = 1
let g:netrw_liststyle = 4
let g:netrw_browse_split = 4

nmap <silent> <C-A> :25 Vexplore<CR>
Bundle 'wakatime/vim-wakatime'
