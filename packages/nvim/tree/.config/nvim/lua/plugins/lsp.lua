return {
    {
        -- code action indicator
        'kosayoda/nvim-lightbulb',
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
    },
    {
        -- lsp status indicator
        'j-hui/fidget.nvim',
        opts = {},
        config = function()
            local fidget = require('fidget')
            vim.notify = fidget.notify
        end,
    },
    {
        -- symbol usage text
        'Wansmer/symbol-usage.nvim',
        event = 'LspAttach',
        opts = {
            vt_position = 'end_of_line',
            request_pending_text = false,
            references = { enabled = true, include_declaration = true },
            definition = { enabled = false },
            implementation = { enabled = false },
        },
    },

    {
        -- predefined language server configurations
        'neovim/nvim-lspconfig',
        dependencies = {
            -- better code actions menus
            'weilbith/nvim-code-action-menu',
            -- schema access for jsonls
            'b0o/SchemaStore.nvim',
        },
        config = function()
            local servers = require('plugins.lsp.servers')
            for name, config in pairs(servers) do
                vim.lsp.config(name, config)
                vim.lsp.enable(name)
            end
        end,
    },
    {
        -- extra linters, formatters, code actions
        'nvimtools/none-ls.nvim',
        config = function()
            require('null-ls').setup {
                sources = require('plugins.lsp.none'),
            }
        end,
    },
    {
        -- clangd extensions
        'p00f/clangd_extensions.nvim',
        opts = {},
    },
    {
        -- jdtls extensions
        'mfussenegger/nvim-jdtls',
    },
    {
        -- lean 4 extensions
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        opts = {
            mappings = true,
        },
    },
    {
        -- rust extensions
        'mrcjkb/rustaceanvim',
        version = '^8',
        lazy = false,
        init = function()
            vim.g.rustaceanvim = {
                tools = {
                    float_win_config = {
                        auto_focus = true,
                    },
                },
                server = {
                    default_settings = {
                        ['rust-analyzer'] = {
                            assist = { importGranularity = 'module' },
                            cargo = { loadOutDirsFromCheck = true },
                            checkOnSave = { command = 'clippy' },
                            procMacro = { enable = true },
                            rustc = { source = 'discover' },
                        },
                    },
                },
            }
        end,
    },
}
