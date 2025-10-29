-- luacheck: globals vim
local plugins = {}

-- jump locations
plugins['phaazon/hop.nvim'] = {
    config = function()
        require('hop').setup {}
        vim.keymap.set('n', '<leader>s', function()
            require('hop').hint_words()
        end)
    end,
}

-- fuzzy picker
plugins['nvim-telescope/telescope.nvim'] = {
    dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzy-native.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
        local telescope = require('modules.navigation.telescope')
        telescope.setup()
    end,
}

-- ide-like breadcrumbs
plugins['Bekaboo/dropbar.nvim'] = {
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
}

-- better quickfix list
-- plugins['kevinhwang91/nvim-bqf'] = {}

-- smooth page-down and page-up
plugins['psliwka/vim-smoothie'] = {}

-- smooth cursor jumps
-- plugins['gen740/SmoothCursor.nvim'] = {
-- config = function()
-- require('smoothcursor').setup()
-- end,
-- }

-- tmux event compatbility
-- plugins['tmux-plugins/vim-tmux-focus-events'] = {}

-- startup dashboard
plugins['goolord/alpha-nvim'] = {
    config = function()
        require('alpha').setup(require('alpha.themes.dashboard').opts)
    end,
}

-- automatically make nonexistent directories
plugins['benizi/vim-automkdir'] = {}

-- restore view on restart
plugins['vim-scripts/restore_view.vim'] = {
    config = function()
        vim.o.viewoptions = 'cursor,folds,slash,unix'
    end,
}

-- project root working directory
plugins['DrKJeff16/project.nvim'] = {
    dependencies = {
        'ibhagwan/fzf-lua',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('project').setup {}
    end,
}

-- better marks
plugins['chentoast/marks.nvim'] = {
    config = function()
        require('marks').setup {}
    end,
}

return plugins
