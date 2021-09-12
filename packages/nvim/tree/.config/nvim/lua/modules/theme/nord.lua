-- luacheck: globals vim
local plugins = {}

plugins['arcticicestudio/nord-vim'] = {
	config = function()
		local o = vim.o
		local exec = vim.api.nvim_exec

		-- Use nord colorscheme
		o.background = 'dark'
		exec(
			[[
try
  colorscheme nord
  catch
endtry
]],
			true
		)

		-- Initialize lualine
		local lualine = require('modules.theme.common.lualine')
		lualine.setup('nord')
	end,
}

return plugins
