return {
    {
        -- jump locations
        'smoka7/hop.nvim',
        config = function()
            require('hop').setup {}
            vim.keymap.set('n', '<leader>s', function()
                require('hop').hint_words()
            end)
        end,
    },
    {
        -- pretty diagnostics view list
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
        keys = {
            { 'gL', '<cmd>Trouble diagnostics toggle<CR>' },
        },
    },
    {
        -- telescope
        'nvim-telescope/telescope.nvim',
        after = { 'folke/trouble.nvim' },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
        config = function()
            local telescope = require('telescope')
            local trouble = require('trouble.sources.telescope')
            local themes = require('telescope.themes')

            telescope.setup {
                defaults = themes.get_ivy {
                    mappings = {
                        i = { ['<c-t>'] = trouble.open },
                        n = { ['<c-t>'] = trouble.open },
                    },
                },
                extensions = {
                    ['ui-select'] = { themes.get_dropdown {} },
                },
            }

            telescope.load_extension('fzf')
            telescope.load_extension('file_browser')
            telescope.load_extension('ui-select')
        end,
        keys = function()
            local pickers = require('plugins.navigation.pickers')
            return {
                {
                    '<leader>ff',
                    function()
                        pickers.files(true)
                    end,
                    desc = 'Find files (relative)',
                },
                {
                    '<leader>fF',
                    function()
                        pickers.files(false)
                    end,
                    desc = 'Find files',
                },
                { '<leader>fg', pickers.git_files, desc = 'Find git files' },
                { '<leader>fh', pickers.oldfiles, desc = 'Recent files' },
                {
                    '<leader>fb',
                    function()
                        pickers.filebrowser(true)
                    end,
                    desc = 'File browser (relative)',
                },
                {
                    '<leader>fB',
                    function()
                        pickers.filebrowser(false)
                    end,
                    desc = 'File browser',
                },
                {
                    '<leader>fr',
                    function()
                        pickers.ripgrep(true)
                    end,
                    desc = 'Ripgrep (relative)',
                },
                {
                    '<leader>fR',
                    function()
                        pickers.ripgrep(false)
                    end,
                    desc = 'Ripgrep',
                },
                { '<leader>fu', pickers.buffers, desc = 'Buffers' },
                { '<leader>fe', pickers.registers, desc = 'Registers' },
                { '<leader>fc', pickers.commands, desc = 'Commands' },
                { '<leader>fC', pickers.command_history, desc = 'Command history' },
                { '<leader>f?', pickers.help, desc = 'Help tags' },
                { '<leader>fm', pickers.man_pages, desc = 'Man pages' },
                { 'gd', pickers.lsp.definitions, desc = 'LSP definitions' },
                { 'grr', pickers.lsp.references, desc = 'LSP references' },
                { '<leader>fs', pickers.lsp.symbols, desc = 'LSP document symbols' },
                { '<leader>fS', pickers.lsp.workspace_symbols, desc = 'LSP workspace symbols' },
            }
        end,
    },
    {
        -- ide-like breadcrumbs
        'Bekaboo/dropbar.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            vim.keymap.set('n', '<leader>fm', function()
                require('dropbar.api').pick()
            end)
        end,
    },
    {
        -- smooth page-down and page-up
        'psliwka/vim-smoothie',
    },
    {
        -- project root working directory
        'DrKJeff16/project.nvim',
        dependencies = {
            'ibhagwan/fzf-lua',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('project').setup {}
        end,
    },
    {
        -- better marks
        'chentoast/marks.nvim',
        config = function()
            require('marks').setup {}
        end,
    },
}
