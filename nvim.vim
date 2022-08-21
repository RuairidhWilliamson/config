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

" Lightline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Themes
Plug 'chriskempson/base16-vim'
Plug 'kyazdani42/nvim-web-devicons' 

" Autocomplete
Plug 'hrsh7th/nvim-compe'

" Language Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
" Plug 'othree/html5.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'evanleck/vim-svelte', {'branch': 'main'}
" Plug 'DingDean/wgsl.vim'
Plug 'LnL7/vim-nix'

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
set scrolloff=3

set mouse=nv
set guifont=RobotoMono\ Nerd\ Font

set termguicolors
set cursorline

filetype plugin indent on
syntax enable
set encoding=utf-8

" <Space> mappings
noremap <silent> <space>f <cmd>Telescope git_files<CR>
noremap <silent> <space>r <cmd>Telescope live_grep<CR>
noremap <silent> <space>s <cmd>Telescope git_status<CR>
noremap <space>p "+p
noremap <space>P "+P
noremap <space>y "+y
noremap <space>Y "+Y

inoremap <S-Insert> <C-R>*

nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <esc>:w<CR>

colorscheme base16-atelier-dune

noremap <silent> <C-c> :Commentary<CR>

let g:airline#extensions#tabline#enabled = 1

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

" Ale lightline
let g:lightline = {}
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = { 'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']], 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ], [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype'] ] }

lua << EOF

-- Telescope

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-[>"] = actions.close,
        ["<ESC>"] = actions.close,
        ["<C-u>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  }
}

-- Mason
require("mason").setup()

-- LSP
require'lspconfig'.rust_analyzer.setup{}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

require'lspconfig'.rnix.setup{
  on_attach = on_attach,
}

-- AUTOCOMPLETE

vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = false;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}

-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

EOF
