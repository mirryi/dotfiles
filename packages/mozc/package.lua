-- luacheck: globals pkg
local lib = require('lib')

pkg.name = 'mozb'
pkg.dependencies:extend('../sh')

-- Load local file if exists
lib.require_opt('local')
