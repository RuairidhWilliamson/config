call plug#begin()

" Conform to editor config defined in projects
Plug 'editorconfig/editorconfig-vim'

" Changes s to be a motion to search for text
Plug 'justinmk/vim-sneak'

" Make the yanked region apparent
Plug 'machakann/vim-highlightedyank'

" Git gutter status
Plug 'airblade/vim-gitgutter'

" Comment toggle
Plug 'tpope/vim-commentary'

Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'flazz/vim-colorschemes'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language Support
Plug 'dense-analysis/ale'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'rust-lang/rust.vim'
Plug 'DingDean/wgsl.vim'

" Plug 'preservim/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'

" Plug 'mhartington/oceanic-next'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" <Space> mappings

noremap <silent> <space>f :GFiles<CR>
noremap <silent> <space>c :Commits<CR>
noremap <space>p "+p
noremap <space>P "+P
noremap <space>y "+y
noremap <space>Y "+Y

inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

inoremap <S-Insert> <C-R>*

nnoremap <silent> <C-s> :w<CR>

" colorscheme OceanicNext
" colorscheme Benokai
colorscheme Atelier_DuneDark

noremap <silent> <C-c> :Commentary<CR>

let g:airline#extensions#tabline#enabled = 1

" NerdTree
" nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeToggle<CR>
" nnoremap <silent> <C-n> :NERDTreeMirrorToggle<CR>
" let g:NERDTreeQuitOnOpen = 1


" ALE
let g:ale_linters = {'rust': ['analyzer']}
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
let g:airline#extensions#ale#enabled = 1

noremap <silent> gd :ALEGoToDefinition<CR>
noremap <silent> gr :ALEFindReferences<CR>
noremap <silent> <space>a :ALECodeAction<CR>
nnoremap <silent> <C-k> :ALEPreviousWrap<CR>
nnoremap <silent> <C-j> :ALENextWrap<CR>

" Coc bindings
" nmap <silent> gd <plug>(coc-definition)
" nmap <silent> gy <plug>(coc-type-definition)
" nmap <silent> gi <plug>(coc-implementation)
" nmap <silent> gr <plug>(coc-references)
" nmap <silent> <C-k> <plug>(coc-diagnostic-prev)
" nmap <silent> <C-j> <plug>(coc-diagnostic-next)
" nmap <silent> <space>a <plug>(coc-codeaction)


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
