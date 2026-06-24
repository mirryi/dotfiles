local lib = require('lib')

pkg.name = 'fd'
pkg.dependencies:extend('../sh')

lib.require_opt('local')
