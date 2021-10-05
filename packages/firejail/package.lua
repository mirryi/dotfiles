local lib = require('lib')

pkg.name = 'firejail'

-- Load local file if exists
lib.require_opt('local')
