
" show matching brackets
set showmatch

" case insensitive matching
set ignorecase

" auto indent
set autoindent

" line numbers
set number
set relativenumber
set relativenumber nu

" auto indent based on file type
filetype plugin indent on

" tabs -> spaces
set expandtab

" set tab size
set shiftwidth=4

" see multiple spaces as tabs
set softtabstop=4

noremap <C-s> :w<CR>

" noremap <C-n> :NERDTreeFocusk<cr>
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

tnoremap <Esc> <C-\><C-n>
noremap <C-_> :terminal<CR>

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

syntax enable

call plug#begin()

Plug 'preservim/nerdtree'

Plug 'arcticicestudio/nord-vim'

Plug 'mhartington/oceanic-next'

Plug 'rust-lang/rust.vim'

Plug 'dense-analysis/ale'

call plug#end()

colorscheme OceanicNext

let g:ale_linters = {'rust': ['analyzer']}

