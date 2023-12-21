-- luacheck: globals vim
local plugins = {}

-- better startup profiling
plugins['tweekmonster/startuptime.vim'] = {}

-- lazygit in-editor
plugins['kdheepak/lazygit.nvim'] = {
    config = function()
        local bind = require('util.bind')
        bind.nmap('<leader>gl', '<cmd>LazyGit<CR>')
    end,
}

-- unix command use
plugins['tpope/vim-eunuch'] = {}

return plugins
