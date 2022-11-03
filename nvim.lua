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
    use 'nvim-lua/lsp-status.nvim'

    -- Luatab
    use 'alvarosevilla95/luatab.nvim'

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'nvim-telescope/telescope-file-browser.nvim'

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

    -- Toggle terminal
    use 'akinsho/toggleterm.nvim'

    -- Mini
    use 'echasnovski/mini.nvim'

    -- FTerm
    use 'numToStr/FTerm.nvim'

    -- Lsp Status
    use 'nvim-lua/lsp-status.nvim'
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
vim.keymap.set('n', '<Space>e', ':Telescope file_browser<CR>', opts)
vim.keymap.set('n', '<Space>b', builtin.builtin, opts)
vim.keymap.set('n', '<Space>p', '"+p', opts)
vim.keymap.set('n', '<Space>P', '"+P', opts)
vim.keymap.set('n', '<Space>y', '"+y', opts)
vim.keymap.set('n', '<Space>Y', '"+Y', opts)
vim.keymap.set('i', '<S-Insert>', '<C-R>*', opts)
vim.keymap.set('n', '<C-c>', ':Commentary<CR>', opts)
vim.keymap.set('v', '<C-c>', ':Commentary<CR>', opts)
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)

-- Global Options
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.autoindent = true

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 3
vim.opt.softtabstop = 4

vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('syntax enable')

vim.opt.mouse = 'nv'

vim.opt.cursorline = true
vim.opt.encoding = 'utf-8'

-- Auto update files
vim.opt.autoread = true
vim.api.nvim_command('au FocusGained,BufEnter * :silent! !')

-- Appearance
vim.opt.guifont = 'Cascadia Code:h11'
vim.opt.guifont = 'RobotoMono Nerd Font'
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.api.nvim_command('colorscheme base16-google-dark')

-- Lsp Status
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- LSP
require'lspconfig'.rust_analyzer.setup{}

vim.diagnostic.config({
    signs = false,
})

local on_attach = function(client, bufnr)
    lsp_status.on_attach(client, buffnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<Space>a', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
	vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
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

require('lspconfig')['wgsl_analyzer'].setup{
	on_attach = on_attach,
}

require'lspconfig'.rnix.setup{
	on_attach = on_attach,
}

-- Mason
require"mason".setup()

-- Autocomplete
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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Telescope
local actions = require('telescope.actions')
require('telescope').setup{
	defaults = {
        file_ignore_patterns = {"vendor", "NugetPackages", "node_modules"},
		mappings = {
			i = {
				["<C-[>"] = actions.close,
				["<ESC>"] = actions.close,
				["<C-u>"] = false,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			}
		}
	},
	extensions = {
		file_browser = {
			theme = 'ivy',
			hijack_netrw = true,
		}
	}
}
require'telescope'.load_extension('file_browser')

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

-- Neovide
vim.api.nvim_command('let g:neovide_cursor_animation_length = 0')

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

-- LSP status
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- Feline
local components = {
    active = {},
    inactive = {}
}

local vi_mode_utils = require('feline.providers.vi_mode')
components.active[1] = {
    {
        provider = '▊ ',
        hl = {
            fg = 'skyblue',
        },
    },
    {
        provider = 'vi_mode',
        hl = function()
            return {
                name = vi_mode_utils.get_mode_highlight_name(),
                fg = vi_mode_utils.get_mode_color(),
                style = 'bold',
            }
        end,
    },
    {
        provider = 'file_info',
        hl = {
            fg = 'white',
            bg = 'oceanblue',
            style = 'bold',
        },
        left_sep = {
            'slant_left_2',
            { str = ' ', hl = { bg = 'oceanblue', fg = 'NONE' } },
        },
        right_sep = {
            { str = ' ', hl = { bg = 'oceanblue', fg = 'NONE' } },
            'slant_right_2',
            ' ',
        },
    },
    {
        provider = 'file_size',
        right_sep = {
            ' ',
            {
                str = 'slant_left_2_thin',
                hl = {
                    fg = 'fg',
                    bg = 'bg',
                },
            },
        },
    },
    {
        provider = 'position',
        left_sep = ' ',
        right_sep = {
            ' ',
            {
                str = 'slant_right_2_thin',
                hl = {
                    fg = 'fg',
                    bg = 'bg',
                },
            },
        },
    },
    {
        provider = 'lsp_client_names',
        left_sep = ' ',
        right_sep = ' ',
    },
    {
        provider = 'lsp_status',
        left_sep = ' ',
        right_sep = ' ',
    },
    {
        provider = 'diagnostic_errors',
        hl = { fg = 'red' },
    },
    {
        provider = 'diagnostic_warnings',
        hl = { fg = 'yellow' },
    },
    {
        provider = 'diagnostic_hints',
        hl = { fg = 'cyan' },
    },
    {
        provider = 'diagnostic_info',
        hl = { fg = 'skyblue' },
    },
}

components.active[2] = {
    {
        provider = 'git_branch',
        hl = {
            fg = 'white',
            bg = 'black',
            style = 'bold',
        },
        right_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = 'black',
            },
        },
    },
    {
        provider = 'git_diff_added',
        hl = {
            fg = 'green',
            bg = 'black',
        },
    },
    {
        provider = 'git_diff_changed',
        hl = {
            fg = 'orange',
            bg = 'black',
        },
    },
    {
        provider = 'git_diff_removed',
        hl = {
            fg = 'red',
            bg = 'black',
        },
        right_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = 'black',
            },
        },
    },
    {
        provider = 'line_percentage',
        hl = {
            style = 'bold',
        },
        left_sep = '  ',
        right_sep = ' ',
    },
    {
        provider = 'scroll_bar',
        hl = {
            fg = 'skyblue',
            style = 'bold',
        },
    },
}

components.inactive[1] = {
    {
        provider = 'file_type',
        hl = {
            fg = 'white',
            bg = 'oceanblue',
            style = 'bold',
        },
        left_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = 'oceanblue',
            },
        },
        right_sep = {
            {
                str = ' ',
                hl = {
                    fg = 'NONE',
                    bg = 'oceanblue',
                },
            },
            'slant_right',
        },
    },
    -- Empty component to fix the highlight till the end of the statusline
    {},
}

custom_providers = {
    lsp_status = function()
        return lsp_status.status()
    end
}

require('feline').setup({components = components, custom_providers = custom_providers})

-- Toggle term
-- require("toggleterm").setup{
--     open_mapping = [[<C-t>]],
--     insert_mappings = true,
--     terminal_mappings = true,
-- }

-- Mini AI
require('mini.ai').setup()

-- Luatab
require('luatab').setup()

-- FTerm
vim.keymap.set('n', '<C-t>', '<Cmd>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<C-t>', '<C-\\><C-n><Cmd>lua require("FTerm").toggle()<CR>')
