-- luacheck: globals pkg
local lib = require('lib')

pkg.name = 'tealdeer'

-- Load local file if exist
lib.require_opt('local')
