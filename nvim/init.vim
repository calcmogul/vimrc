" Set editor config root
if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
else
    let s:editor_root=expand("~/.vim")
endif

" Setting up Vundle - the vim plugin bundler
let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/vundle/README.md'
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    " silent execute "! mkdir -p ~/." . s:editor_path_name . "/bundle"
    silent call mkdir(s:editor_root . '/bundle', "p")
    silent execute "!git clone https://github.com/gmarik/vundle " . s:editor_root . "/bundle/vundle"
    let vundle_installed=0
endif
let &rtp = &rtp . ',' . s:editor_root . '/bundle/vundle/'
call vundle#rc(s:editor_root . '/bundle')

" Syntax highlighting
Plugin 'w0ng/vim-hybrid'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rust-lang/rust.vim'

" Markdown support
Plugin 'godlygeek/tabular'

" Git support
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
set updatetime=250

Plugin 'lervag/vimtex'
let g:tex_flavor = 'xelatex'

Plugin 'tpope/vim-surround'

" Install bundles
if vundle_installed == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
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
autocmd BufNewFile,BufRead *.inc set syntax=cpp
autocmd BufNewFile,BufRead *.tex set syntax=tex

" Show filename in titlebar of window
set title
set titleold=

" Make the 81st column stand out
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 80)

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

" statusline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
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
if has('nvim')
    set undodir=$HOME/.config/nvim/undo
else
    set undodir=$HOME/.vim/undo
endif

" How many undos
set undolevels=10000000

" Number of lines to save for undo
set undoreload=10000000
