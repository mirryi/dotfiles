-- luacheck: globals vim
local plugins = {}

-- jump locations
plugins['phaazon/hop.nvim'] = {
    config = function()
        local hop = require('hop')
        local bind = require('util.bind')

        hop.setup {}
        bind.nmap('<leader>s', '<cmd>lua require("hop").hint_words()<CR>')
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
        vim.keymap.set('n', '<leader>fm', '<cmd>lua require("dropbar.api").pick()<CR>')
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
    config = function()
        require('project_nvim').setup {}
    end,
}

-- better marks
plugins['chentoast/marks.nvim'] = {
    config = function()
        require('marks').setup {}
    end,
}

return plugins
