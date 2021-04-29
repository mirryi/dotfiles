-- luacheck: globals vim
local U = require('util')

local treesitter = U.require('nvim-treesitter.configs')
if treesitter ~= nil then
    treesitter.setup {
        ensure_installed = 'maintained',
        highlight = {enable = true, disable = {'python', 'rust', 'zsh'}},
        indent = {enable = true, disable = {'rust'}}
    }
end

