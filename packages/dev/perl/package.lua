local lib = require('lib')

pkg.name = 'perl'
pkg.dependencies:extend('../../sh')

-- Load local file if exists
lib.require_opt('local')
