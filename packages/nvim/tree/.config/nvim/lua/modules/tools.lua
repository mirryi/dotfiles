-- luacheck: globals vim
local plugins = {}

-- Better startup profiling
plugins['tweekmonster/startuptime.vim'] = {}

-- Lazygit
plugins['kdheepak/lazygit.nvim'] = {
	config = function()
		local bind = require('util.bind')
		bind.nmap('<leader>lg', '<cmd>LazyGit<CR>')
	end,
}

-- Unix command use
plugins['tpope/vim-eunuch'] = {}

-- Run code snippets
-- plugins['michaelb/sniprun'] = {
-- run = 'bash ./install.sh',
-- config = function()
-- local bind = require('util.bind')
-- local sniprun = require('sniprun')
-- sniprun.setup({})

-- -- Set mappings
-- bind.vmap('<leader>ff', '<Plug>SnipRun')
-- bind.nmap('<leader>f', '<Plug>SnipRunOperator')
-- bind.nmap('<leader>ff', '<Plug>SnipRun')
-- end,
-- }

return plugins
