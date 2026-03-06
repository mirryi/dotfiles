local lib = require('lib')

pkg.name = 'nvim'
pkg.dependencies:extend('../sh')

local profile = require('profile').nvim
pkg.files.extra:extend {
    src = 'tree/.config/nvim/lua/plugins/theme/' .. profile.theme .. '.lua',
    dest = '.config/nvim/lua/plugins/theme.lua',
}

-- Load local file if it exists
lib.require_opt('local')
