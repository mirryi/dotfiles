-- luacheck: globals vim
local lualine = require('lualine')

local M = {}

M.setup = function(theme)
	lualine.setup({
		options = { theme = theme },
		sections = {
			lualine_c = { { 'diagnostics', sources = { 'nvim_diagnostic' } }, 'filename', 'lsp_progress' },
		},
	})
end

return M
