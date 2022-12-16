local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require 'packer'.startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Editor config defined in projects
    use 'editorconfig/editorconfig-vim'

    -- Git signs
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    -- Make the yanked region apparent
    use 'machakann/vim-highlightedyank'

    -- Comment toggle
    use {
        'tpope/vim-commentary',
        config = function()
            -- Binds to <C-/>
            vim.keymap.set('n', '<C-_>', ':Commentary<CR>')
            vim.keymap.set('v', '<C-_>', ':Commentary<CR>')
        end
    }

    -- Feline
    use 'feline-nvim/feline.nvim'

    -- Luatab
    use {
        'alvarosevilla95/luatab.nvim',
        config = function()
            require('luatab').setup()
        end
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<Space>f', '<Cmd>Telescope find_files<CR>', opts)
            vim.keymap.set('n', '<Space>F', '<Cmd>Telescope git_files<CR>', opts)
            vim.keymap.set('n', '<Space>r', '<Cmd>Telescope live_grep<CR>', opts)
            vim.keymap.set('n', '<Space>s', '<Cmd>Telescope git_status<CR>', opts)
            vim.keymap.set('n', '<Space>e', '<Cmd>Telescope file_browser<CR>', opts)
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<Space>l', builtin.diagnostics, opts)
            vim.keymap.set('n', '<Space>b', builtin.builtin, opts)
            vim.keymap.set('n', '<Space>d', builtin.grep_string, opts)
            vim.keymap.set('n', '<Space><Space>', builtin.resume, opts)

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

        end
    }
    use 'nvim-telescope/telescope-file-browser.nvim'

    -- Themes
    use 'chriskempson/base16-vim'
    use 'kyazdani42/nvim-web-devicons' 

    -- Autocomplete
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'petertriho/cmp-git'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Language Support
    use 'neovim/nvim-lspconfig'
    use {
        'williamboman/mason.nvim',
        config = function()
            require"mason".setup()
        end
    }
    use 'LnL7/vim-nix'
    use 'NoahTheDuke/vim-just'

    -- Color picker
    use {
        'uga-rosa/ccc.nvim',
        config = function()
            local ccc = require('ccc')
            local mapping = ccc.mapping
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<space>c", ":CccPick<cr>", opts)
            ccc.setup({
                mappings = {
                    ["<esc>"] = mapping.quit,
                }
            })
        end
    }

    -- Mini
    use {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.ai').setup()
        end
    }

    -- FTerm
    use {
        'numToStr/FTerm.nvim',
        config = function()
            vim.keymap.set('n', '<C-t>', '<Cmd>lua require("FTerm").toggle()<CR>')
            vim.keymap.set('t', '<C-t>', '<C-\\><C-n><Cmd>lua require("FTerm").toggle()<CR>')
        end
    }

    -- Lsp Status
    use 'nvim-lua/lsp-status.nvim'

    -- Bootstrap packer
    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Global binds
local opts = { noremap = true, silent = true }

-- ctrl + s to save
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>', opts)
vim.keymap.set('v', '<C-s>', '<ESC>:w<CR>', opts)

-- Copy paste from system
vim.keymap.set('n', '<Space>p', '"+p', opts)
vim.keymap.set('n', '<Space>P', '"+P', opts)
vim.keymap.set('n', '<Space>y', '"+y', opts)
vim.keymap.set('n', '<Space>Y', '"+Y', opts)
vim.keymap.set('i', '<S-Insert>', '<C-R>+', opts)

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
vim.opt.list = true
vim.opt.listchars = 'tab:> ,nbsp:+'

vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('syntax enable')

vim.opt.mouse = 'nv'

vim.opt.cursorline = true
vim.opt.encoding = 'utf-8'

-- Auto update files
vim.opt.autoread = true
vim.api.nvim_command('au FocusGained,BufEnter * :silent! !')
vim.api.nvim_command('au BufNewFile,BufRead *.wgsl set syntax=rust')
vim.api.nvim_command('au BufNewFile,BufRead *.wgsl setlocal commentstring=//\\ %s')

-- Appearance
vim.opt.guifont = 'Cascadia Code:h11'
vim.opt.guifont = 'RobotoMono Nerd Font'
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.api.nvim_command('colorscheme base16-google-dark')

-- Neovide
vim.api.nvim_command('let g:neovide_cursor_animation_length = 0')

-- Auto complete
vim.o.completeopt = "menu,menuone,noselect"

local cmp = require'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer', keyword_length = 3 },
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.confirm { behaviour = cmp.ConfirmBehavior.Insert, select = true },
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
    }),
}
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
    })
})
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Lsp Status
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- Lsp Config
vim.diagnostic.config({
    signs = false,
})

local on_attach = function(client, bufnr)
    lsp_status.on_attach(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<Space>a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<C-f>', vim.lsp.buf.format, bufopts)
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
    vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            procMacro = {
                enable = true,
            },
            checkOnSave = {
                command = "clippy"
            },
            diagnostics = {
                disabled = {"inactive-code"},
            },
            completion = {
                postfix = {
                    enable = false,
                },
            },
        }
    }
}

require('lspconfig')['wgsl_analyzer'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require'lspconfig'.rnix.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Feline
local components = {
    active = {},
    inactive = {}
}

-- Most of this is the default feline components with a few exceptions
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
        provider = {
            name = 'file_info',
            opts = {
                path_sep = '/',
                type = 'relative-short',
            },
        },
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
        provider = 'position',
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
