" Set editor config root
let s:editor_root=expand("~/.vim")

" Set up vim-plug
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Syntax highlighting
Plug 'w0ng/vim-hybrid'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
Plug 'udalov/kotlin-vim'

" Markdown support
Plug 'godlygeek/tabular'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
set updatetime=250

Plug 'lervag/vimtex'
let g:tex_flavor = 'xelatex'

" statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" hexmode
Plug 'fidian/hexmode'
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'

" Initialize plugin system
call plug#end()

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set autoindent
set smartindent

" Syntax highlighting
syn on
colorscheme hybrid
set background=dark
autocmd BufNewFile,BufRead *.inc set filetype=cpp
autocmd BufNewFile,BufRead *.inc set syntax=cpp
autocmd BufNewFile,BufRead *.tex set syntax=tex

" Show filename in titlebar of window
set title
set titleold=

" Color line length limits
set colorcolumn=81,101

" Reduce number of keystrokes
nnoremap ; :

" If the current buffer has never been saved, it will have no name.
" Call the file browser to save it, otherwise just save it.
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
nnoremap <silent> <A-Left> :bp<CR>
inoremap <silent> <A-Left> <Esc>:bp<CR>a
nnoremap <silent> <A-Right> :bn<CR>
inoremap <silent> <A-Right> <Esc>:bn<CR>a
nnoremap <silent> <A-Down> :bd<CR>
inoremap <silent> <A-Down> <Esc>:bd<CR>a

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

let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'y', 'z', 'error', 'warning' ]
    \ ]

" Save undos after file closes
set undofile

" Where to save undo histories
set undodir=$HOME/.vim/undo

" How many undos
set undolevels=10000000

" Number of lines to save for undo
set undoreload=10000000
