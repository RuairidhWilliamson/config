local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
    'editorconfig/editorconfig-vim',
    'machakann/vim-highlightedyank',
    'feline-nvim/feline.nvim',
    'nvim-lua/plenary.nvim',
    {'nvim-telescope/telescope.nvim', branch = '0.1.x' },
    'nvim-telescope/telescope-ui-select.nvim',
    'xiyaowong/telescope-emoji.nvim',
    'chriskempson/base16-vim',
    'kyazdani42/nvim-web-devicons',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'petertriho/cmp-git',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'neovim/nvim-lspconfig',
    'nvim-lua/lsp-status.nvim',
    'LnL7/vim-nix',
    'NoahTheDuke/vim-just',
    -- 'williamboman/mason.nvim',
    -- 'williamboman/mason-lspconfig.nvim',
    'ziglang/zig.vim',
    'elmcast/elm-vim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/playground',
    'navarasu/onedark.nvim',
    {'stevearc/oil.nvim', config = true },
    {'saecki/crates.nvim', config = true },
    {'lewis6991/gitsigns.nvim', config = true },
    {'alvarosevilla95/luatab.nvim', config = true },
    {'tpope/vim-commentary', config = function()
        vim.keymap.set('n', '<C-_>', ':Commentary<CR>')
        vim.keymap.set('v', '<C-_>', ':Commentary<CR>')
    end},
    {'echasnovski/mini.nvim', config = function()
        require('mini.ai').setup()
    end},
    {'numToStr/FTerm.nvim', config = function()
        vim.keymap.set('n', '<C-t>', '<Cmd>lua require("FTerm").toggle()<CR>')
        vim.keymap.set('t', '<C-t>', '<C-\\><C-n><Cmd>lua require("FTerm").toggle()<CR>')
    end},
    -- {"iamcco/markdown-preview.nvim", config = function()
    --     vim.fn["mkdp#util#install"]()
    -- end}
})

-- LSP Servers
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local lsp_servers = {
    'rust_analyzer',
    -- 'sumneko_lua',
    -- 'taplo',
    -- 'clangd',
    'bashls',
    'pyright',
    'tsserver',
    'eslint',
    'html',
    -- 'cssls',
    -- 'elmls',
}

if vim.loop.os_uname().sysname == 'Linux' then
    table.insert(lsp_servers, 'zls')
    table.insert(lsp_servers, 'wgsl_analyzer')
    table.insert(lsp_servers, 'rnix')
    table.insert(lsp_servers, 'svelte')
    table.insert(lsp_servers, 'gopls')
end

if vim.loop.os_uname().sysname == 'Darwin' then
    table.insert(lsp_servers, 'gopls')
end

-- Global binds
local opts = { noremap = true, silent = true }

-- ctrl + s to save
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>', opts)
vim.keymap.set('v', '<C-s>', '<ESC>:w<CR>', opts)

-- Paste from system
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

vim.opt.list = false
vim.opt.listchars = 'nbsp:+'

vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('syntax enable')

vim.opt.mouse = 'nv'

vim.opt.cursorline = true
vim.opt.encoding = 'utf-8'

-- Auto update files
vim.opt.autoread = true
vim.api.nvim_command('au FocusGained,BufEnter * :silent! !')

-- Custom file types
vim.api.nvim_command('au BufNewFile,BufRead *.ogn set syntax=json')
vim.api.nvim_command('au BufNewFile,BufRead *.wgsl set syntax=rust')
vim.api.nvim_command('au BufNewFile,BufRead *.ers set syntax=rust')
vim.api.nvim_command('au BufNewFile,BufRead *.svelte set syntax=html')
vim.api.nvim_command('au BufNewFile,BufRead *.wgsl setlocal commentstring=//\\ %s')
vim.api.nvim_command('set nowrap')

-- Appearance
vim.opt.guifont = 'Cascadia Code:h11'
vim.opt.guifont = 'RobotoMono Nerd Font'
vim.opt.termguicolors = true
vim.opt.background = 'dark'
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "bash", "cpp", "css", "elm", "fish", "git_config", "git_rebase", "gitcommit", "gitignore", "html", "json", "proto", "rust", "python", "scss", "typescript", "wgsl", "zig" }
}
require'onedark'.setup {
    style = 'darker'
}
require'onedark'.load()
vim.api.nvim_set_hl(0, 'Identifier', { link = '@lsp' })
-- vim.api.nvim_command('hi Identifier ctermfg=7 guifg=#c5c8c6')
-- vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })
-- vim.api.nvim_set_hl(0, 'Include', { link = 'Keyword' })
-- vim.api.nvim_set_hl(0, 'Delimiter', { link = 'Identifier' })
-- vim.api.nvim_set_hl(0, '@lsp.type.namespace.rust', { link = 'Comment' })
-- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--   vim.api.nvim_set_hl(0, group, {})
-- end
-- vim.api.nvim_command('hi link Structure Type')
-- vim.api.nvim_command('hi rustExternCrate ctermfg=4 guifg=#3971ed')

-- Neovide
vim.api.nvim_command('let g:neovide_cursor_animation_length = 0')

-- Telescope
require('telescope').setup({
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Space>f', function() builtin.find_files({hidden = true}) end, opts)
vim.keymap.set('n', '<Space>F', function() builtin.find_files({hidden = true, no_ignore = true}) end, opts)
vim.keymap.set('n', '<Space>w', builtin.grep_string, opts)
vim.keymap.set('n', '<Space>r', builtin.live_grep, opts)
vim.keymap.set('n', '<Space>s', builtin.git_status, opts)
vim.keymap.set('n', '<Space>m', '<Cmd>Telescope emoji<CR>', opts)
vim.keymap.set('n', '<Space>l', builtin.diagnostics, opts)
vim.keymap.set('n', '<Space>b', builtin.builtin, opts)
vim.keymap.set('n', '<Space><Space>', builtin.resume, opts)

local actions = require('telescope.actions')
require'telescope'.setup{
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
require'telescope'.load_extension('ui-select')
require'telescope'.load_extension('emoji')


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

-- require'mason'.setup()
-- require'mason-lspconfig'.setup {
--     ensure_installed = lsp_servers,
-- }

vim.diagnostic.config({
    signs = false,
})

local on_attach = function(client, bufnr)
    lsp_status.on_attach(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<F3>', ':RustOpenDocs<CR>', bufopts)
    -- vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<F5>', ':LspRestart<CR>', opts)
    vim.keymap.set('n', '<C-f>', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
    vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, v in pairs(lsp_servers) do
    require'lspconfig'[v].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

require'lspconfig'['rust_analyzer'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
        RustOpenDocs = {
            function()
                vim.lsp.buf_request(vim.api.nvim_get_current_buf(), 'experimental/externalDocs', vim.lsp.util.make_position_params(), function(err, url)
                    if err then
                        error(tostring(err))
                    else
                        vim.fn['netrw#BrowseX'](url, 0)
                    end
                end)
            end,
            description = 'Open docs for symbol under cursor',
        },
    },
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                -- target = "x86_64-pc-windows-gnu",
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
                privateEditable = {
                    enable = true,
                },
            },
        }
    }
}

require'lspconfig'['tsserver'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        completions = {
            completeFunctionCalls = true,
        },
    },
}

require'lspconfig'['elmls'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = require'lspconfig'.util.root_pattern('elm.json'),
}

-- require'lspconfig'['sumneko_lua'].setup {
--     settings = {
--         Lua = {
--             diagnostics = {
--                 globals = {'vim'},
--             },
--             workspace = {
--                 library = vim.api.nvim_get_runtime_file("", true),
--                 checkThirdParty = false,
--             },
--             telemetry = {
--                 enable = false,
--             },
--         }
--     }
-- }

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

local custom_providers = {
    lsp_status = function()
        return lsp_status.status()
    end
}

require('feline').setup({components = components, custom_providers = custom_providers})
