" Use vim settings instead of vi settings
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

" Display tabs and trailing spaces
set listchars=tab:>~,nbsp:_,trail:.
set list

" Prevent mouse starting visual selection
set mouse=

" Send more characters for redraws
set ttyfast

" Indentation
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

" Syntax highlighting
syn on
colorscheme hybrid
set background=dark

" Show filename in titlebar of window
set title
set titleold=

" Make the 81st column stand out
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Reduce number of keystrokes
nnoremap ; :

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif

let mapleader="\<Space>"

" Write buffer leader
nnoremap <silent> <leader>w :<C-u>Update<CR>
vmap <silent> <leader>w <Esc>:w<CR>gv

" Copy and paste to system clipboard
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" For cycling through and deleting buffers
nnoremap <silent> <leader><Left> :bp<CR>
nnoremap <silent> <leader><Right> :bn<CR>
nnoremap <silent> <leader><Down> :bd<CR>

" Reload buffer when external changes detected
set autoread

"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 500 files
"           | |    +--Remember up to 10000 lines in each register
"           | |    |      +--Remember up to 1MB in each register
"           | |    |      |     +--Remember last 1000 search patterns
"           | |    |      |     |     +---Remember last 1000 commands
"           | |    |      |     |     |
"           v v    v      v     v     v
set viminfo=h,'500,<10000,s1000,/1000,:1000

" statusline
set statusline=%t\      " tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}] " file format
set statusline+=%h      " help file flag
set statusline+=%m      " modified flag
set statusline+=%r      " read only flag
set statusline+=%y      " filetype
set statusline+=%=      " left/right separator
set statusline+=%c,     " cursor column
set statusline+=%l/%L   " cursor line/total lines
set statusline+=\ %P    " percent through file
