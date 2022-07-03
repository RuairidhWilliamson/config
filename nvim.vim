call plug#begin()

Plug 'preservim/nerdtree'
Plug 'mhartington/oceanic-next'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'flazz/vim-colorschemes'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

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
inoremap <S-Insert> <C-R>*

noremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> :w<CR>

" colorscheme OceanicNext
colorscheme Benokai

noremap <C-/> :Commentary<CR>

let g:airline#extensions#tabline#enabled = 1

" NerdTree
" nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeMirrorToggle<CR>
let g:NERDTreeQuitOnOpen = 1

" ALE
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

nnoremap <silent> <C-k> :ALEPreviousWrap<CR>
nnoremap <silent> <C-j> :ALENextWrap<CR>

highlight link ALEError DiagnosticUnderlineError

" Neovide
let g:neovide_transparency=0.9
let g:neovide_remember_window_size = v:true
let g:neovide_cursor_animation_length=0

noremap <F11> :call FullscreenToggle()<CR>

function! FullscreenToggle()
    if g:neovide_fullscreen
        let g:neovide_fullscreen=v:false
    else
        let g:neovide_fullscreen=v:true
    endif
endfunction
