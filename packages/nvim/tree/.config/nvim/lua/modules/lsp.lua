-- luacheck: globals vim
local handlers = require('modules.lsp.handlers')

local plugins = {}

-- code action indicator
plugins['kosayoda/nvim-lightbulb'] = {
    opts = {
        sign = {
            enabled = false,
        },
        virtual_text = {
            enabled = true,
            text = '',
        },
        autocmd = { enabled = true },
    },
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
        local fidget = require('fidget')
        fidget.setup()
        vim.notify = fidget.notify
    end,
}

-- symbols outline
-- plugins['hedyhli/outline.nvim'] = {
-- config = function()
-- require('outline').setup()

-- vim.keymap.set('n', 'go', '<cmd>Outline<CR>')
-- end,
-- }

-- symbol usage text
plugins['Wansmer/symbol-usage.nvim'] = {
    event = 'LspAttach',
    config = function()
        require('symbol-usage').setup {
            vt_position = 'end_of_line',
            request_pending_text = false,
            references = { enabled = true, include_declaration = true },
            definition = { enabled = false },
            implementation = { enabled = false },
        }
    end,
}

-- hover hints
plugins['soulis-1256/eagle.nvim'] = {}

-- treesitter support
plugins['nvim-treesitter/nvim-treesitter'] = {
    dependencies = {
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-refactor',
        -- auto close html/xml tags
        'windwp/nvim-ts-autotag',
        {
            'romgrk/nvim-treesitter-context',
            opts = { enable = true, throttle = true },
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
        {
            'hiphish/rainbow-delimiters.nvim',
            setup = function()
                require('rainbow-delimiters.setup').setup()
            end,
        },
        -- swapping of parameters, lists, arrays, etc.
        'mizlan/iswap.nvim',
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
            'tmux',
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
        -- support for ts_ls extensions
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
        -- 'ray-x/lsp_signature.nvim',
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
-- plugins['mfussenegger/nvim-dap'] = {
-- dependencies = {
-- { 'rcarriga/nvim-dap-ui', dependencies = 'nvim-neotest/nvim-nio' },
-- 'theHamsta/nvim-dap-virtual-text',
-- },
-- config = function()
-- require('modules.lsp.dap')
-- end,
-- }

-- enhanced java language server
plugins['mfussenegger/nvim-jdtls'] = {
    ft = { 'java' },
    config = function()
        require('modules.lsp.servers.jdtls')
    end,
}

-- enhanced scala language server and tools
plugins['scalameta/nvim-metals'] = {
    ft = { 'scala', 'sbt', 'java' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function()
        local function metals_status_handler(_, status, ctx)
            local val = {}
            if status.hide then
                val = { kind = 'end' }
            elseif status.show then
                val = { kind = 'begin', message = status.text }
            elseif status.text then
                val = { kind = 'report', message = status.text }
            else
                return
            end
            local info = { client_id = ctx.client_id }
            local msg = { token = 'metals', value = val }
            vim.lsp.handlers['$/progress'](nil, msg, info)
        end

        vim.g['metals/status'] = metals_status_handler

        local metals_capabilities = vim.deepcopy(handlers.capabilities)
        metals_capabilities.offsetEncoding = { 'utf-8' }

        local metals_config = require('metals').bare_config()
        metals_config.on_attach = handlers.on_attach
        metals_config.capabilities = metals_capabilities
        metals_config.init_options.statusBarProvider = true
        metals_config.settings = {
            useGlobalExecutable = true,
            showInferredType = true,
            showImplicitArguments = true,
            showImplicitConversionsAndClasses = true,
            superMethodLensesEnabled = true,
            enableSemanticHighlighting = false,
        }

        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
            pattern = self.ft,
            callback = function()
                require('metals').initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end,
}

-- enhanced flutter language server and tools
plugins['akinsho/flutter-tools.nvim'] = {
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('modules.lsp.servers.flutter')
    end,
}

-- lean4 support
plugins['Julian/lean.nvim'] = {
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
    dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-lua/plenary.nvim',
    },
    -- see details below for full configuration options
    opts = {
        lsp = {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
        },
        mappings = true,
    },
}

-- enahcned rust language server and tools
plugins['simrat39/rust-tools.nvim'] = {
    ft = { 'rust' },
    dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    opts = {
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
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
            settings = {
                ['rust-analyzer'] = {
                    assist = { importGranularity = 'module' },
                    cargo = { loadOutDirsFromCheck = true },
                    checkOnSave = { command = 'clippy' },
                    procMacro = { enable = true },
                    rustc = { source = 'discover' },
                },
            },
        },
    },
}

-- enhanced clangd and tools
plugins['p00f/clangd_extensions.nvim'] = {
    config = function()
        local clangd_extensions = require('clangd_extensions')
        clangd_extensions.setup {}
    end,
}

return plugins
