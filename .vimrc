"Use Vim settings, rather then Vi settings (much better!).
set nocompatible




filetype off                          " required

"=====================================================
" Vundle settings
"=====================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'            " let Vundle manage Vundle, required

"---------=== Code/project navigation ===-------------
Plugin 'scrooloose/nerdtree'          " Project and file navigation
Plugin 'majutsushi/tagbar'            " Class/module browser

Plugin 'dreyks/ir_black'              " ir_black color scheme

"------------------=== Other ===----------------------
Plugin 'bling/vim-airline'            " Lean & mean status/tabline for vim
"Plugin 'fisadev/FixedTaskList.vim'    " Pending tasks list
"Plugin 'rosenfeld/conque-term'        " Consoles as buffers
Plugin 'tpope/vim-surround'           " Parentheses, brackets, quotes, XML tags, and more

" --- Ruby/Rails ---
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'              " Ultimate rails plugin
Plugin 'tpope/vim-bundler'            " Bundle plugin
Plugin 'ain/vim-capistrano'           " *.cap support

"--------------=== Snippets support ===---------------
"Plugin 'garbas/vim-snipmate'          " Snippets manager
"Plugin 'MarcWeber/vim-addon-mw-utils' " dependencies #1
"Plugin 'tomtom/tlib_vim'              " dependencies #2
"Plugin 'honza/vim-snippets'           " snippets repo

"---------------=== Languages support ===-------------
" --- Python ---
"Plugin 'klen/python-mode'            " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
"Plugin 'davidhalter/jedi-vim'        " Jedi-vim autocomplete plugin
"Plugin 'mitsuhiko/vim-jinja'         " Jinja support for vim
"Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim

call vundle#end()               " required
filetype on
filetype plugin on
filetype plugin indent on




" General settings
color ir_black

" Set to auto read when a file is changed from the outside
set autoread

" back to xterm title on vim exit
"set title
"set titleold=""
"set titlestring=VIM:\ %F

set backspace=2
syntax on
set number
set title

set noshowmode " airline does this

""status bar always visible
"set laststatus=2
"" Set status line
"set statusline=%F       "tail of the filename
""set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
""set statusline+=%{&ff}] "file format
""set statusline+=%h      "help file flag
"set statusline+=%m      "modified flag
"set statusline+=%r      "read only flag
"set statusline+=%y      "filetype
"set statusline+=%=      "left/right separator
"set statusline+=%c,     "cursor column
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file



"tab for 2 spaces
set shiftwidth=2
set tabstop=2
set smarttab
set et
set ai "Auto indent
filetype indent on
set si "Smart indent
set wrap "Wrap lines


set incsearch   "find the next match as we type the search
"set hlsearch    "highlight searches by default

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

"make vim save and load the folding of the document each time it loads"
"also places the cursor in the last place that it was left."
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

if has("multi_byte")
  set encoding=utf-8
endif


" Snipmate
"let g:snippets_dir = "~/.vim/vim-snippets/snippets"

" Vim-Airline
set laststatus=2
let g:airline_theme='bubblegum'
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" TagBar
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0 " autofocus on open

" NerdTree
map <silent> <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=[]

imap <F5> <ESC>:buffers<CR>:buffer<Space>
nmap <F5> :buffers<CR>:buffer<Space>
imap <C-q> <ESC>:bd<CR>
nmap <C-q> :bd<CR>
:set hidden
