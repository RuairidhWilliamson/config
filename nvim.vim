call plug#begin()

Plug 'preservim/nerdtree'

Plug 'mhartington/oceanic-next'

Plug 'airblade/vim-gitgutter'

Plug 'rust-lang/rust.vim'

Plug 'dense-analysis/ale'

Plug 'tpope/vim-commentary'

Plug 'vim-airline/vim-airline'

Plug 'ryanoasis/vim-devicons'

Plug 'xuyuanp/nerdtree-git-plugin'

call plug#end()

set showmatch
set ignorecase
set autoindent

set number
set norelativenumber
set norelativenumber nu

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set mouse=nv
set guifont=RobotoMono\ Nerd\ Font

filetype plugin indent on
syntax enable
set encoding=utf-8

noremap <S-Insert> "*p
noremap <silent> <C-s> :w<CR>

nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

tnoremap <Esc> <C-\><C-n>
noremap <C-_> :terminal<CR>

colorscheme OceanicNext

noremap <C-/> :Commentary<CR>

let g:NERDTreeQuitOnOpen = 1

let g:ale_linters = {'rust': ['analyzer']}
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
let g:airline#extensions#ale#enabled = 1

noremap <silent> <C-]> :ALEGoToDefinition<CR>
noremap <silent> <C-[> :ALEFindReferences<CR>
noremap <silent> <C-.> :ALECodeAction<CR>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:airline#extensions#tabline#enabled = 1

highlight link ALEError DiagnosticUnderlineError
