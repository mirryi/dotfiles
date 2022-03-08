-- luacheck: globals vim
local plugins = {}

-- {{{ startuptime.vim : Better startup profiling
plugins['tweekmonster/startuptime.vim'] = {}
-- }}}
-- {{{ lazygit.nvim : Lazygit
plugins['kdheepak/lazygit.nvim'] = {
    config = function()
        local bind = require('util.bind')
        bind.nmap('<leader>gl', '<cmd>LazyGit<CR>')
    end,
}
-- }}}
-- {{{ vim-eunuch : Unix command use
plugins['tpope/vim-eunuch'] = {}
-- }}}
-- {{{ aw-watcher-vim : ActivityWatch integration
plugins['ActivityWatch/aw-watcher-vim'] = {}
-- }}}

return plugins
