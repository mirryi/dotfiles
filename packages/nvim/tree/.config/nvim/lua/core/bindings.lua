-- luacheck: globals vim
local bind = require('util.bind')

-- Toggle between relative and absolute numbering
bind.nmap('<leader>=', '<cmd>set relativenumber!<CR>')

-- Fix previous spelling error
bind.imap('<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', { noremap = true })
