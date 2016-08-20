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

" --- UI ---
Plugin 'dreyks/ir_black'              " ir_black color scheme
Plugin 'bling/vim-airline'            " Lean & mean status/tabline for vim
Plugin 'vim-airline/vim-airline-themes'

" --- Ruby/Rails ---
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'              " Ultimate rails plugin
Plugin 'tpope/vim-endwise'            " Autoinserting 'end'
" Plugin 'tpope/vim-bundler'            " Bundle plugin
Plugin 'ain/vim-capistrano'           " *.cap support

" --- JS ---
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" --- Crystal ---
Plugin 'rhysd/vim-crystal'

"------------------=== Other ===----------------------
Plugin 'Raimondi/delimitMate'          " automatically closes quotes
Plugin 'henrik/vim-indexed-search'     " 'Match x of y' when searching
"Plugin 'tpope/vim-surround'           " Parentheses, brackets, quotes, XML tags, and more


call vundle#end()               " required
filetype on
filetype plugin on
filetype plugin indent on

" matching 'end' keywords
runtime macros/matchit.vim

" General settings
color ir_black_256

" Set to auto read when a file is changed from the outside
set autoread

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

syntax on
set number
set title

set hidden
set wildmode=list:longest

"tab for 2 spaces
set shiftwidth=2
set tabstop=2
set smarttab
set et
set ai "Auto indent
filetype indent on
set si "Smart indent
set wrap "Wrap lines

" ================ Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

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

if has("multy_byte") && $LANG !~ '\v\cutf-?8$'
  set encoding=utf-8
endif

" Vim-Airline
set noshowmode " airline takes care of mode
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

" Buffers
imap <F5> <ESC>:buffers<CR>:buffer<Space>
nmap <F5> :buffers<CR>:buffer<Space>

nmap <tab><right> :bn<CR>
" numpad +
imap Ol <ESC>:bn<CR>
nmap Ol :bn<CR>
imap Ok <ESC>:bn<CR>
nmap Ok :bn<CR>

nmap <tab><left> :bp<CR>
" numpad -
imap OS <ESC>:bp<CR>
nmap OS :bp<CR>
imap Om <ESC>:bp<CR>
nmap Om :bp<CR>

" close current buffer
imap <C-q> <ESC>:bd<CR>
nmap <C-q> :bd<CR>

" scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif






" new

" when pasting copy pasted text back to 
" buffer instead replacing with owerride
xnoremap p pgvy
