" General "{{{
set mouse=a
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
" colorscheme onedark  " Use onedark as the colorscheme
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
Plugin 'rust-lang/rust.vim'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'Lokaltog/powerline-fonts'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'arcticicestudio/nord-vim'
Plugin 'lervag/vimtex'

call vundle#end()

" Required for devicons
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set encoding=utf-8

let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:vim_markdown_math = 1
" " }}}

" Ctags " {{{
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
    \]
\}
" " }}}

" Pandoc Markdown+LaTeX " {{{
let g:vimtex_compiler_latexmk = {
   \ 'build_dir' : '/tmp',
   \ 'options' : [
   \   '-pdf',
   \   '-verbose',
   \   '-file-line-error',
   \   '-synctex=1',
   \   '-interaction=nonstopmode',
   \]
\}

function s:MDSettings()
    "    inoremap <buffer> <Leader>n \note[item]{}<Esc>i
    noremap <buffer> <Leader>b :! pandoc -t beamer % -o %<.pdf<CR><CR>
    noremap <buffer> <Leader>l :! pandoc -t latex % -o %<.pdf<CR>
    noremap <buffer> <Leader>v :! zathura %<.pdf 2>&1 >/dev/null &<CR><CR>

    " adjust syntax highlighting for LaTeX parts
    "   inline formulas:
    syntax region Statement oneline matchgroup=Delimiter start="\$" end="\$"
    "   environments:
    syntax region Statement matchgroup=Delimiter start="\\begin{.*}" end="\\end{.*}" contains=Statement
    "   commands:
    syntax region Statement matchgroup=Delimiter start="{" end="}" contains=Statement
endfunction

autocmd BufRead,BufNewFile *.md setfiletype markdown
autocmd FileType markdown :call <SID>MDSettings()
" " }}}

colorscheme nord  " Use nord as the colorscheme

filetype plugin indent on  " Automatically detect file types.
