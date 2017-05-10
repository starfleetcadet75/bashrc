" General "{{{
set history=256  " Number of things to remember in history
set autoread
set clipboard+=unnamedplus  " Yanks go on clipboard instead
set pastetoggle=<F10>  " toggle between paste and normal: for 'safer' pasting from kckup
set nowritebackup
set nobackup
set directory=/tmp// " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
" Match and search
set hlsearch  " Highlight searches by default
set ignorecase  " Use case insensitive search, except when using capital letters
set smartcase  " ...unless we type a capital
set incsearch  " Find the next match as we type the search
" Scrolling
set scrolloff=8  "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
" "}}}

" Formatting "{{{
set nowrap
set textwidth=0  " Don't wrap lines by default
set backspace=indent,eol,start  " more powerful backspacing

set tabstop=2  " Set the default tabstop
set softtabstop=2
set shiftwidth=2  " Set the default shift width for indents
set expandtab  " Make tabs into spaces (set by tabstop)
set smarttab  " Smarter tab levels

set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>
" "}}}

" Visual "{{{
set number  " Show line numbers on the left
set showmatch  " Show matching brackets.
set matchtime=5  " Bracket blinking.
set novisualbell  " No blinking
set noerrorbells  " No noise.
set vb t_vb=  " disable any beeps or flashes on error
set ruler  " Show ruler
set showcmd  " Display an incomplete command in the lower right corner of the
set cmdheight=2  " Set the command window height to 2 lines

set foldenable  " Turn on folding
set foldmethod=marker  " Fold on the marker
set foldlevel=100  " Don't autofold anything (but I can still fold manually)
set foldopen=block,hor,mark,percent,quickfix,tag  " what movements open folds 

if (has("termguicolors"))
  set termguicolors
endif

syntax on
colorscheme onedark
" "}}}

" Keybindings " {{{
" Navigate to other windows in any mode using `Alt+{h,j,k,l}`
:tnoremap <A-h> <C-\><C-n><C-w>h
:tnoremap <A-j> <C-\><C-n><C-w>j
:tnoremap <A-k> <C-\><C-n><C-w>k
:tnoremap <A-l> <C-\><C-n><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
" "}}}

filetype off  " required for Vundle
" Plugins " {{{
set rtp+=~/.config/nvim/bundle/Vundle.vim  " Set the runtime path to include Vundle and initialize
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'  " Let Vundle manage Vundle, required
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'mhinz/vim-signify'

call vundle#end()

let g:airline_theme='onedark'
" " }}}

filetype plugin indent on  " Automatically detect file types.
