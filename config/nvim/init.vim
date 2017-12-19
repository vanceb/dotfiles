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
"Plug 'altercation/vim-colors-solarized'
"Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'iCyMind/NeoSolarized'

" Autogenerate ctags index for files being edited
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

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

""""""""""""""""""
" Plugin Settings
"
""""""""""""""""""

" Syntastic
"""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Map key for toggle syntax checking
nnoremap <leader>s :SyntasticToggleMode<CR>
" Map keys to jump to next/prev error
nnoremap <leader>. :lnext<CR>
nnoremap <leader>, :lprevious<CR>

" NERDTree
""""""""""
map <C-\> :NERDTreeToggle<CR>
" Close nvim if NERDTree is the only remaining buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Tagbar
""""""""
map <C-T> :TagbarToggle<CR>

" CtrlP
"""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'


""""""""""
" Map keys
"
""""""""""

" Searching
"""""""""""
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Formatting
""""""""""""
" Reflow a paragraph of text
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL


" Color scheme (terminal)
"""""""""""""""""""""""""
" These settings seem to depend on which solarized scheme is enabled

"set t_Co=256
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1

if has('termguicolors') && !has('gui_running')
   set termguicolors
endif

set background=dark
colorscheme NeoSolarized
