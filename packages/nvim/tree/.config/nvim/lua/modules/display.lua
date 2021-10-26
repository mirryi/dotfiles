-- luacheck: globals vim
local plugins = {}

-- RGB, hex color highlighting
plugins['norcalli/nvim-colorizer.lua'] = {
	config = function()
		local colorizer = require('colorizer')
		colorizer.setup({
			'*',
			css = { rgb_fn = true },
			html = { names = false },
			pandoc = { names = false },
			tex = { names = false },
		})
	end,
}

-- Indent guides
plugins['lukas-reineke/indent-blankline.nvim'] = {
	config = function()
		local g = vim.g

		-- Set guide character
		g.indentLine_char = 'ˌ'
		-- Disable on dashboard
		g.indentLine_fileTypeExclude = { 'dashboard' }
		-- Disable setting concealcursor
		g.indentLine_setConceal = 0
	end,
}

-- Markdown preview
plugins['npxbr/glow.nvim'] = {
	ft = { 'markdown', 'pandoc' },
	config = function()
		local bind = require('util.bind')
		bind.nmap('<leader>p', '<cmd>Glow<CR>')
	end,
}

return plugins