-- luacheck: globals vim
local plugins = {}

plugins['SirVer/ultisnips'] = {
	config = function()
		-- Disable default UltiSnips mappings
		vim.g.UltiSnipsExpandTrigger = '<C-j>'
		vim.g.UltiSnipsListSnippets = '<NUL>'
		vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
		vim.g.UltiSnipsJumpBackwardTrigger = '<C-h>'
	end,
}

plugins['hrsh7th/nvim-cmp'] = {
	requires = {
		{ 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
		{ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
		{ 'quangnguyen30192/cmp-nvim-ultisnips', after = { 'nvim-cmp', 'ultisnips' } },
		{ 'hrsh7th/cmp-path', after = 'nvim-cmp' },
		{ 'f3fora/cmp-spell', after = 'nvim-cmp' },
		{ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
		{ 'ray-x/lsp_signature.nvim' },
	},
	config = function()
		require('modules.completion.config').nvim_cmp()
	end,
}

plugins['windwp/nvim-autopairs'] = {
	after = 'nvim-cmp',
	config = function()
		require('modules.completion.config').autopairs()
	end,
}

return plugins
