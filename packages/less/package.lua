require('lib')

pkg.name = 'less'
pkg.dependencies:extend('../sh')

-- Load local file if exists
require_opt('local')
