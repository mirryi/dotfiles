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
plugins['ahmedkhalf/project.nvim'] = {
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
