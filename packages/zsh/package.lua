local lib = require('lib')
local lfs = require('lfs')

pkg.name = 'zshrc'

-- Load local file if it exists
lib.require_opt('local')
