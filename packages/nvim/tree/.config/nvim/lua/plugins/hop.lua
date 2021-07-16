local hop = require('hop')
local bind = require('util.bind')

hop.setup {}

bind.nmap('<leader>s', '<cmd>lua require("hop").hint_words()<CR>')
