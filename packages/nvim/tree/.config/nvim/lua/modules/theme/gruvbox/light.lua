-- luacheck: globals vim
-- Initialize colorscheme
local shared = require('modules.theme.gruvbox.shared')
shared.colorscheme('light', 'original', 'medium')

-- Initialize lualine
local lualine = require('modules.theme.common.lualine')
-- TODO: light theme
lualine.setup('gruvbox-material')
