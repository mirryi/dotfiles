require('lib')

pkg.name = 'pacman'
pkg.dependencies:extend('../sh')

-- Load local file if exists
require_opt('local')
