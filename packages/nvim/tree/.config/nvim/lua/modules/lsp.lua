-- luacheck: globals vim
local plugins = {}

-- code action indicator
plugins['kosayoda/nvim-lightbulb'] = {
    config = function()
        local lightbulb = require('nvim-lightbulb')
        lightbulb.setup {
            sign = {
                enabled = false,
            },
            virtual_text = {
                enabled = true,
                text = '',
            },
            autocmd = { enabled = true },
        }
    end,
}

-- highlight same item instances
plugins['RRethy/vim-illuminate'] = {
    config = function()
        local bind = require('util.bind')
        bind.nmap('<C-.>', [[ <cmd>lua require('illuminate').next_reference{wrap=true}<CR> ]])
        bind.nmap('<C-,>', [[ <cmd>lua require('illuminate').next_reference{reverse=true, wrap=true}<CR> ]])
    end,
}

-- pretty diagnostics view list
plugins['folke/lsp-trouble.nvim'] = {
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    config = function()
        local trouble = require('trouble')
        trouble.setup {}

        local bind = require('util.bind')
        bind.nmap('gL', '<cmd>TroubleToggle document_diagnostics<CR>')
        bind.nmap('gwL', '<cmd>TroubleToggle workspace_diagnostics<CR>')
    end,
}

-- lsp status indicator
plugins['j-hui/fidget.nvim'] = {
    config = function()
        require('fidget').setup()
    end,
}

-- symbols outline
plugins['hedyhli/outline.nvim'] = {
    config = function()
        require('outline').setup()

        vim.keymap.set('n', 'go', '<cmd>Outline<CR>')
    end,
}

-- symbol usage text
plugins['Wansmer/symbol-usage.nvim'] = {
    event = 'LspAttach',
    config = function()
        require('symbol-usage').setup()
    end,
}

-- hover hints
plugins['soulis-1256/hoverhints.nvim'] = {
    config = function()
        require('hoverhints').setup()
    end,
}

-- treesitter support
plugins['nvim-treesitter/nvim-treesitter'] = {
    dependencies = {
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-refactor',
        -- auto close html/xml tags
        'windwp/nvim-ts-autotag',
        {
            'romgrk/nvim-treesitter-context',
            config = function()
                require('treesitter-context').setup { enable = true, throttle = true }
            end,
        },
        'haringsrob/nvim_context_vt',
        -- spellcheck using treesitter
        -- {
        --     'lewis6991/spellsitter.nvim',
        --     after = { 'nvim-treesitter' },
        --     config = function()
        --         require('spellsitter').setup()
        --     end,
        -- },
        -- rainbow parentheses
        'p00f/nvim-ts-rainbow',
        {
            'luochen1990/rainbow',
            ft = { 'latex', 'ocaml', 'reason', 'rust', 'tex' },
            setup = function()
                vim.g.rainbow_active = 1
            end,
        },
        -- swapping of parameters, lists, arrays, etc.
        {
            'mizlan/iswap.nvim',
            config = function()
                require('iswap').setup {}
            end,
        },
        -- dimming of unused code.
        -- {
        -- 'narutoxy/dim.lua',
        -- after = { 'nvim-treesitter', 'nvim-lspconfig' },
        -- config = function()
        -- require('dim').setup()
        -- end,
        -- },
    },
    config = function()
        local treesitter = require('nvim-treesitter.configs')
        local highlight_disabled = {
            'agda',
            'cmake',
            'help',
            'latex',
            'make',
            'markdown',
            'pandoc',
            'r',
            'ruby',
            'rust',
            'scss',
            'tex',
            'toml',
            'yaml',
        }
        treesitter.setup {
            -- ensure_installed = 'all',
            highlight = {
                enable = true,
                disable = highlight_disabled,
            },
            indent = { enable = true },
            refactor = {
                enable = true,
                highlight_definitions = { enable = true },
                highlight_current_scope = { enable = false },
                keymaps = { goto_definition = 'gd' },
            },
            -- External modules
            autotag = { enable = true },
            context_commentstring = { enable = true },
            rainbow = {
                enable = true,
                disable = highlight_disabled,
                extended_mode = true,
            },
        }
    end,
}

-- predefined language server configurations
plugins['neovim/nvim-lspconfig'] = {
    dependencies = {
        -- non-lsp linter integration
        'nvimtools/none-ls.nvim',
        -- support for tsserver extensions
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        -- rust inline type indications
        'nvim-lua/lsp_extensions.nvim',
        -- better UIs
        { 'RishabhRD/nvim-lsputils', dependencies = { 'RishabhRD/popfix' } },
        -- better code actions menus
        { 'weilbith/nvim-code-action-menu' },
        -- virtual text for types
        'jubnzv/virtual-types.nvim',
        -- schema access for jsonls
        'b0o/SchemaStore.nvim',
        -- signature help for completion
        'ray-x/lsp_signature.nvim',
        -- also use notify
        'nvim-notify',
    },
    config = function()
        -- show diagnostics on hover
        -- TODO use lua api for autocmds
        vim.api.nvim_exec(
            [[ aug lsp_autocmds autocmd CursorHold * lua vim.diagnostic.open_float({focus = false}) aug END ]],
            true
        )

        require('modules.lsp.servers')
    end,
}

-- debugging support
plugins['mfussenegger/nvim-dap'] = {
    dependencies = { 'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text' },
    config = function()
        require('modules.lsp.dap')
    end,
}

-- enhanced java language server
plugins['mfussenegger/nvim-jdtls'] = {
    ft = { 'java' },
    config = function()
        require('modules.lsp.servers.jdtls')
    end,
}

-- enhanced scala language server and tools
plugins['scalameta/nvim-metals'] = {
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('modules.lsp.servers.metals')
    end,
}

-- enhanced flutter language server and tools
plugins['akinsho/flutter-tools.nvim'] = {
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('modules.lsp.servers.flutter')
    end,
}

-- enahcned rust language server and tools
plugins['simrat39/rust-tools.nvim'] = {
    dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local rust_tools = require('rust-tools')

        local handlers = require('modules.lsp.handlers')
        local on_attach = handlers.on_attach
        local capabilities = handlers.capabilities

        rust_tools.setup {
            tools = {
                autoSetHints = true,
                runnables = { use_telescope = true },
                inlay_hints = {
                    only_current_line = false,
                    show_parameter_hints = true,
                    max_len_align = false,
                },
                crate_graph = { output = nil, full = true },
            },
            server = {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        assist = { importGranularity = 'module' },
                        cargo = { loadOutDirsFromCheck = true },
                        checkOnSave = { command = 'clippy' },
                        procMacro = { enable = true },
                    },
                },
            },
        }
    end,
}

-- enhanced clangd and tools
plugins['p00f/clangd_extensions.nvim'] = {
    config = function()
        local clangd_extensions = require('clangd_extensions')
        local inlay_hints = require('clangd_extensions.inlay_hints')

        clangd_extensions.setup {}

        inlay_hints.setup_autocmd()
        inlay_hints.set_inlay_hints()
    end,
}

return plugins
