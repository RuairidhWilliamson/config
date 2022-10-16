require 'packer'.startup(function(use)
	-- Packer
	use 'wbthomason/packer.nvim'

	-- Editor config defined in projects
	use 'editorconfig/editorconfig-vim'

	-- Git signs
	use 'lewis6991/gitsigns.nvim'

	-- Make the yanked region apparent
	use 'machakann/vim-highlightedyank'

	-- Comment toggle
	use 'tpope/vim-commentary'

	-- Feline
	use 'feline-nvim/feline.nvim'

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Themes
	use 'chriskempson/base16-vim'
	use 'kyazdani42/nvim-web-devicons' 

	-- Autocomplete
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'

	-- Language Support
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'LnL7/vim-nix'

	-- Tree sitter
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	-- Color picker
	use 'uga-rosa/ccc.nvim'

end)

-- Global binds
local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>', opts)
vim.keymap.set('n', '<Space>f', '<Cmd>Telescope find_files<CR>', opts)
vim.keymap.set('n', '<Space>F', '<Cmd>Telescope git_files<CR>', opts)
vim.keymap.set('n', '<Space>r', '<Cmd>Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<Space>s', '<Cmd>Telescope git_status<CR>', opts)
vim.keymap.set('n', '<Space>b', builtin.builtin, opts)
vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
vim.keymap.set('n', '<Space>p', '"+p', opts)
vim.keymap.set('n', '<Space>P', '"+P', opts)
vim.keymap.set('n', '<Space>y', '"+y', opts)
vim.keymap.set('n', '<Space>Y', '"+Y', opts)
vim.keymap.set('i', '<S-Insert>', '<C-R>*', opts)
vim.keymap.set('n', '<C-c>', ':Commentary<CR>', opts)
vim.keymap.set('v', '<C-c>', ':Commentary<CR>', opts)

-- Global Options
vim.api.nvim_set_option('showmatch', true)
vim.api.nvim_set_option('ignorecase', true)
vim.api.nvim_set_option('autoindent', true)

vim.api.nvim_set_option('number', true)
vim.api.nvim_set_option('relativenumber', false)

vim.api.nvim_set_option('expandtab', true)
vim.api.nvim_set_option('shiftwidth', 4)
vim.api.nvim_set_option('softtabstop', 4)
vim.api.nvim_set_option('tabstop', 4)
vim.api.nvim_set_option('scrolloff', 3)

vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('syntax enable')

vim.api.nvim_set_option('mouse', 'nv')

vim.api.nvim_set_option('cursorline', true)
vim.api.nvim_set_option('encoding', 'utf-8')

-- Auto update files
vim.api.nvim_set_option('autoread', true)
vim.api.nvim_command('au FocusGained,BufEnter * :silent! !')

-- Appearance
vim.api.nvim_set_option('guifont', 'RobotoMono Nerd Font')
vim.api.nvim_set_option('termguicolors', true)
vim.api.nvim_set_option('background', 'dark')
vim.api.nvim_command('colorscheme base16-google-dark')

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
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<Space>a', vim.lsp.buf.code_action, bufopts)
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
local ccc = require('ccc')
local mapping = ccc.mapping
ccc.setup({
	mappings = {
		["<esc>"] = mapping.quit,
	}
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>c", ":CccPick<cr>", opts)

-- Git
require('gitsigns').setup()

-- Feline
require('feline').setup()

