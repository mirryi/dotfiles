-- luacheck: globals vim
local U = require('util')
local g = vim.g

-- Disable default keybinds
g.tq_map_keys = 0

-- Use custom keybind
U.bind.nmap('<leader>t', '<cmd>ThesaurusQueryReplaceCurrentWord<CR>')
