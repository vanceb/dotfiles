" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

""""""""""""""""
" Manage Plugins
"
""""""""""""""""
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Checkout plugins on https://vimawesome.com/
"
" Make sure you use single quotes

" Tree view file plugin
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Git support
Plug 'tpope/vim-fugitive'

" Syntax checking
Plug 'scrooloose/syntastic'

" Surround matching
Plug 'tpope/vim-surround'

" Fuzzy searching
Plug 'ctrlpvim/ctrlp.vim'

" Great statusline
Plug 'vim-airline/vim-airline'

" Solarized colour scheme
Plug 'altercation/vim-colors-solarized'

" Display current file hierarchy using tags
Plug 'majutsushi/tagbar'

" Vim mode plugins
"Plug 'klen/python-mode'

" Initialize plugin system
call plug#end()

""""""""""""""""""""
" Configure python
"
""""""""""""""""""""

" Set to use python installed by homebrew
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

""""""""""""""""""""
" Define some basics
"
""""""""""""""""""""

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on


" Define the leader key
let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd


""""""""""
" Map keys
"
""""""""""

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL


" Key mappings for the plugins
map <C-\> :NERDTreeToggle<CR>
" Close nvim if NERDTree is the only remaining buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Color scheme (terminal)
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1
"if has('termguicolors') && !has('gui_running')
"   set termguicolors
"endif
set background=dark
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
colorscheme solarized
