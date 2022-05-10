-- luacheck: globals vim
local plugins = {}

-- {{{ hop.vim : Jump locations
plugins['phaazon/hop.nvim'] = {
    config = function()
        local hop = require('hop')
        local bind = require('util.bind')

        hop.setup {}
        bind.nmap('<leader>s', '<cmd>lua require("hop").hint_words()<CR>')
    end,
}
-- }}}
-- {{{ telescope.nvim : Fuzzy picker
plugins['nvim-telescope/telescope.nvim'] = {
    requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzy-native.nvim' },
        { 'nvim-telescope/telescope-file-browser.nvim' },
        { 'nvim-telescope/telescope-ui-select.nvim' }
    },
    config = function()
        local telescope = require('modules.navigation.telescope')
        telescope.setup()
    end,
}
-- }}}
-- {{{ nvim-bqf : Better quickfix list
plugins['kevinhwang91/nvim-bqf'] = {}
-- }}}
-- {{{ vim-smoothie : Smooth page-down and page-up
plugins['psliwka/vim-smoothie'] = {}
-- }}}
-- {{{ vim-tmux-focus-events : tmux event compatbility
-- plugins['tmux-plugins/vim-tmux-focus-events'] = {}
-- }}}
-- {{{ alpha-nvim : Dashboard
plugins['goolord/alpha-nvim'] = {
    config = function()
        require('alpha').setup(require('alpha.themes.dashboard').opts)
    end,
}
-- }}}
-- {{{ vim-automkdir : Automatically make nonexistent directories
plugins['benizi/vim-automkdir'] = {}
-- }}}
-- {{{ restore_view.vim : Restore view
plugins['vim-scripts/restore_view.vim'] = {
    config = function()
        vim.o.viewoptions = 'cursor,folds,slash,unix'
    end,
}
-- }}}
-- {{{ project.nvim : Project root working directory
plugins['ahmedkhalf/project.nvim'] = {
    config = function()
        require('project_nvim').setup {}
    end,
}
-- }}}

return plugins
