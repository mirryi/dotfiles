local lib = require('lib')

pkg.name = 'c'
pkg.dependencies:extend('../../sh')

-- Load local file if it exists
lib.require_opt('local')
