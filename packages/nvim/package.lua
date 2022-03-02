local lib = require('lib')

pkg.name = 'nvim'
pkg.dependencies:extend('../sh')

local profile = require('profile').nvim
pkg.files.extra:extend {
	src = 'tree/.config/nvim/lua/modules/theme/' .. profile.theme .. '.lua',
	dest = '.config/nvim/lua/modules/theme/active.lua',
}

-- Load local file if it exists
lib.require_opt('local')
