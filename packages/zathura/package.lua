local lib = require('lib')
local profile = require('profile').zathura

pkg.name = 'zathura'
pkg.dependencies:extend('../sh')

pkg.files.extra:push {
    src = 'themes/' .. profile.theme,
    dest = '.config/zathura/theme',
}

-- Load local file if it exists
lib.require_opt('local')
