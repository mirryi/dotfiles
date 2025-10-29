-- luacheck: globals vim
local plugins = {}

-- better startup profiling
plugins['tweekmonster/startuptime.vim'] = {}

-- lazygit in-editor
plugins['kdheepak/lazygit.nvim'] = {
    config = function()
        vim.keymap.set('n', '<leader>gl', '<cmd>LazyGit<CR>')
    end,
}

-- unix command use
plugins['tpope/vim-eunuch'] = {}

return plugins
