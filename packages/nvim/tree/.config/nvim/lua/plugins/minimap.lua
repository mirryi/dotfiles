-- luacheck: globals vim
local bind = require('util.bind')

-- Toggle minimap
bind.nmap('<leader>m', '<cmd>MinimapToggle<CR>', { silent = true })
