-- luacheck: globals vim

local plugins = {}

-- Preview search and replace
plugins['markonm/traces.vim'] = {}

-- Comment and uncomment with keybindings (<leader>c<space>)
plugins['scrooloose/nerdcommenter'] = {
	config = function()
		local g = vim.g
		g.NERDSpaceDelims = 1
	end,
}

-- Automated text table spacing
plugins['godlygeek/tabular'] = {
	ft = { 'asciidoc', 'markdown', 'pandoc', 'rmarkdown', 'text', 'tex' },
}

-- Easy text alignment
plugins['junegunn/vim-easy-align'] = {
	config = function()
		local bind = require('util.bind')

		bind.nmap('gA', '<Plug>(EasyAlign)')
		bind.vmap('gA', '<Plug>(EasyAlign)')
	end,
}

-- Toggle between short/long constructs
plugins['AndrewRadev/splitjoin.vim'] = {
	config = function()
		local g = vim.g
		local bind = require('util.bind')

		-- Disable default mappings
		g.splitjoin_split_mapping = ''
		g.splitjoin_join_mapping = ''

		-- Use custom mappings
		bind.nmap('<leader>j', '<cmd>SplitjoinJoin<CR>')
		bind.nmap('<leader>s', '<cmd>SplitjoinSplit<CR>')
	end,
}

return plugins
