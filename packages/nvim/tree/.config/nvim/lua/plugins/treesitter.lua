-- luacheck: globals vim
local U = require('util')

local treesitter = U.require('nvim-treesitter.configs')
if treesitter ~= nil then
	treesitter.setup({
		ensure_installed = 'maintained',
		highlight = {
			enable = true,
			disable = { 'latex', 'ocaml', 'r', 'rust', 'scss', 'tex', 'yaml' },
		},
		indent = { enable = true, disable = { 'lua', 'rust' } },
		refactor = {
			enable = true,
			highlight_definitions = { enable = true },
			highlight_current_scope = { enable = false },
			keymaps = { goto_definition = 'gd' },
		},
		-- External modules
		autotag = { enable = true },
		context_commentstring = { enable = true },
	})
end
