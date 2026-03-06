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
        -- telescope
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        config = function()
            local telescope = require('plugins.navigation.telescope')
            telescope.setup()
        end,
    },
    {
        -- ide-like breadcrumbs
        'Bekaboo/dropbar.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
            },
        },
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
