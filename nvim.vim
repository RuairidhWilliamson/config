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
Plug 'josa42/nvim-lightline-lsp'

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Themes
Plug 'chriskempson/base16-vim'
Plug 'kyazdani42/nvim-web-devicons' 

" Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

" Language Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'LnL7/vim-nix'

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Color picker
Plug 'ziontee113/color-picker.nvim'

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

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" <Space> mappings
noremap <silent> <space>f <cmd>Telescope find_files<CR>
noremap <silent> <space>F <cmd>Telescope git_files<CR>
noremap <silent> <space>r <cmd>Telescope live_grep<CR>
noremap <silent> <space>s <cmd>Telescope git_status<CR>
noremap <space>p "+p
noremap <space>P "+P
noremap <space>y "+y
noremap <space>Y "+Y

inoremap <S-Insert> <C-R>*

nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <esc>:w<CR>

set background=dark
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
let g:lightline.active = { 'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']], 'right': [[  'lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok' ], [ 'lsp_status' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ], [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype'] ] }

call lightline#lsp#register()

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
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
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
  vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<C-f>', vim.lsp.buf.formatting, bufopts)
end

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {
          cargo = {
              allFeatures = true
              },
          checkOnSave = {
              command = "clippy"
              },
      }
    }
}

require'lspconfig'.rnix.setup{
  on_attach = on_attach,
}

-- AUTOCOMPLETE

vim.o.completeopt = "menu,menuone,noselect"

local cmp = require'cmp'
cmp.setup {
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
    },
    mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.confirm { behaviour = cmp.ConfirmBehavior.Insert, select = true },
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    }),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

-- Treesitter
vim.cmd[[au BufRead,BufNewFile *.wgsl	set filetype=wgsl]]
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"wgsl"},
    highlight = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
}

-- Color picker
require'color-picker'

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>c", "<cmd>PickColor<cr>", opts)

EOF
