"Use Vim settings, rather then Vi settings (much better!).
set nocompatible

colo ir_black

" Set to auto read when a file is changed from the outside
set autoread

set backspace=2
syntax on
set number
set title


"status bar always visible
set laststatus=2
" Set status line
set statusline=%F       "tail of the filename
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file



"tab for 2 spaces
set shiftwidth=2
set tabstop=2
set smarttab
set et
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


set incsearch   "find the next match as we type the search
"set hlsearch    "highlight searches by default

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

if has("multi_byte")
  set encoding=utf-8
endif


"Ctrl+s to save
map <C-s> :w<cr>
imap <C-s> <ESC>:w<cr>a

"Ctrl+q to quit, hold shift to discard changes
map <C-q> :q<cr>
imap <C-q> <ESC>:q<cr>
map <C-S-q> :q!<cr>
imap <C-S-q> <ESC>:q!<cr>
