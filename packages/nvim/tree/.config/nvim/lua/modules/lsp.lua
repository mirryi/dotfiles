local plugins = {}

-- Code action indicator
plugins['kosayoda/nvim-lightbulb'] = {
	config = function()
		require('modules.lsp.config').lightbulb()
	end,
}

-- Highlight same item instances
plugins['RRethy/vim-illuminate'] = {
	config = function()
		require('modules.lsp.config').illuminate()
	end,
}

-- Pretty diagnostics view list
plugins['folke/lsp-trouble.nvim'] = {
	requires = {
		{ 'kyazdani42/nvim-web-devicons' },
	},
	config = function()
		require('modules.lsp.config').trouble()
	end,
}

-- Treesitter
plugins['nvim-treesitter/nvim-treesitter'] = {
	requires = {
		'nvim-treesitter/nvim-treesitter-refactor',
		-- Auto close HTML/XML tags
		'windwp/nvim-ts-autotag',
		-- Treesitter-based commentstring
		-- 'JoosepAlviste/nvim-ts-context-commentstring'
		{
			'romgrk/nvim-treesitter-context',
			config = function()
				require('treesitter-context').setup({ enable = true, throttle = true })
			end,
		},
		'haringsrob/nvim_context_vt',
		-- Spellcheck using treesitter
		{
			'lewis6991/spellsitter.nvim',
			after = { 'nvim-treesitter' },
			config = function()
				require('spellsitter').setup()
			end,
		},
		-- Rainbow parentheses
		'p00f/nvim-ts-rainbow',
		-- Swapping of paremters, lists, arrays, etc.
		{
			'mizlan/iswap.nvim',
			config = function()
				require('iswap').setup({})
			end,
		},
	},
	config = function()
		require('modules.lsp.config').treesitter()
	end,
}

-- Non-lsp linter integration
plugins['mfussenegger/nvim-lint'] = {
	config = function()
		require('modules.lsp.config').lint()
	end,
}

-- Predefined language server configurations
plugins['neovim/nvim-lspconfig'] = {
	requires = {
		-- Support for tsserver extensions
		{ 'jose-elias-alvarez/nvim-lsp-ts-utils' },
		-- Rust inline type indications
		{ 'nvim-lua/lsp_extensions.nvim', ft = { 'rust' } },
		-- Better UIs
		{ 'RishabhRD/nvim-lsputils', requires = { { 'RishabhRD/popfix' } } },
		-- Better code actions menus
		-- { 'weilbith/nvim-code-action-menu' },
	},
	config = function()
		require('modules.lsp.config').lspconfig()
	end,
}

-- Better java support
plugins['mfussenegger/nvim-jdtls'] = {
	ft = { 'java' },
	config = function()
		require('modules.lsp.config').jdtls()
	end,
}

-- Better scala support
plugins['scalameta/nvim-metals'] = {
	ft = { 'scala', 'sbt' },
	config = function()
		require('modules.lsp.config').metals()
	end,
}

-- Better flutter support
plugins['akinsho/flutter-tools.nvim'] = {
	requires = { { 'nvim-lua/plenary.nvim' } },
	config = function()
		require('modules.lsp.config').flutter()
	end,
}

-- Better rust utilities
plugins['simrat39/rust-tools.nvim'] = {
	requires = {
		{ 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
	},
	after = { 'nvim-lspconfig' },
	config = function()
		require('modules.lsp.config').rust_tools()
	end,
}

return plugins
