-- luacheck: globals vim
local plugins = {}

-- Jump locations
plugins['phaazon/hop.nvim'] = {
	config = function()
		local hop = require('hop')
		local bind = require('util.bind')

		hop.setup({})
		bind.nmap('<leader>s', '<cmd>lua require("hop").hint_words()<CR>')
	end,
}

-- Tag management
plugins['ludovicchabant/vim-gutentags'] = {
	config = function()
		local g = vim.g
		g.gutentags_cache_dir = g.nvim_cache .. '/gutentags'
	end,
}

-- Fuzzy picker
plugins['nvim-telescope/telescope.nvim'] = {
	requires = {
		{ 'nvim-lua/popup.nvim' },
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope-fzy-native.nvim' },
	},
	config = function()
		require('modules.navigation.config').telescope()
	end,
}

-- Better quickfix list
plugins['kevinhwang91/nvim-bqf'] = {}

-- Smooth page-down and page-up
plugins['psliwka/vim-smoothie'] = {}

-- tmux event compatbility
plugins['tmux-plugins/vim-tmux-focus-events'] = {}

-- Dashboard
plugins['glepnir/dashboard-nvim'] = {
	config = function()
		vim.g.dashboard_default_executive = 'telescope'
	end,
}

-- Automatically make nonexistent directories
plugins['benizi/vim-automkdir'] = {}

-- Restore view
plugins['vim-scripts/restore_view.vim'] = {
	config = function()
		vim.o.viewoptions = 'cursor,folds,slash,unix'
	end,
}

return plugins
