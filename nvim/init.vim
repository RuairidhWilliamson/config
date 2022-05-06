set showmatch
set ignorecase
set autoindent

set number
set relativenumber
set relativenumber nu

filetype plugin indent on

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

noremap <S-Insert> "*p
noremap <C-s> :w<CR>

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

Plug 'mhartington/oceanic-next'

Plug 'airblade/vim-gitgutter'

call plug#end()

colorscheme OceanicNext

let g:ale_linters = {'rust': ['analyzer']}

