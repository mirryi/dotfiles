-- luacheck: globals pkg
local lib = require('lib')

pkg.name = 'flutter'
pkg.dependencies:extend('../../sh')

-- Load local file if it exists
lib.require_opt('local')
