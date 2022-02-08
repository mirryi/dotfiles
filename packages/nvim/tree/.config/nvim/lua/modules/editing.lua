-- luacheck: globals vim

local plugins = {}

-- {{{ traces.vim : Preview search and replace
plugins['markonm/traces.vim'] = {}
-- }}}
-- {{{ nerdcommenter : Comment and uncomment with keybindings
plugins['scrooloose/nerdcommenter'] = {
	-- This plugin binds <leader>c<space>
	config = function()
		local g = vim.g
		g.NERDSpaceDelims = 1
	end,
}
-- }}}
-- {{{ tabular : Automated text table spacing
plugins['godlygeek/tabular'] = {
	ft = { 'asciidoc', 'markdown', 'pandoc', 'rmarkdown', 'text', 'tex' },
}
-- }}}
-- {{{ vim-easy-align : Easy text alignment
plugins['junegunn/vim-easy-align'] = {
	config = function()
		local bind = require('util.bind')

		bind.nmap('gA', '<Plug>(EasyAlign)')
		bind.vmap('gA', '<Plug>(EasyAlign)')
	end,
}
-- }}}
-- {{{ splitjoin.vim : Toggle between short/long constructs
plugins['AndrewRadev/splitjoin.vim'] = {
	config = function()
		local g = vim.g
		local bind = require('util.bind')

		-- Disable default mappings
		g.splitjoin_split_mapping = ''
		g.splitjoin_join_mapping = ''

		-- Use custom mappings
		bind.nmap('<leader>j', '<cmd>SplitjoinJoin<CR>')
		bind.nmap('<leader>S', '<cmd>SplitjoinSplit<CR>')
	end,
}
-- }}}
-- {{{ range-highlight.nvim : Highlight selected ranges
plugins['winston0410/range-highlight.nvim'] = {
	requires = { { 'winston0410/cmd-parser.nvim' } },
	config = function()
		require('range-highlight').setup({})
	end,
}
-- }}}
-- {{{ vim-surround : More surround movements
plugins['tpope/vim-surround'] = {}
-- }}}
-- {{{ tabout.nvim : Tab out of parentheses
plugins['abecodes/tabout.nvim'] = {
	config = function()
		require('tabout').setup({
			tabkey = '<C-n>',
			backwards_tabkey = '<C-b>',
			act_as_tab = false,
			act_as_shift_tab = false,
			enable_backwards = true,
			completion = false,
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = '`', close = '`' },
				{ open = '(', close = ')' },
				{ open = '[', close = ']' },
				{ open = '{', close = '}' },
				{ open = '$', close = '$' },
			},
			ignore_beginning = true,
			exclude = {},
		})
	end,
	after = { 'nvim-treesitter' },
}
-- }}}

return plugins
