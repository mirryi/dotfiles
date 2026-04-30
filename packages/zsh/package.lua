local lib = require('lib')

pkg.name = 'zshrc'

-- Load local file if it exists
lib.require_opt('local')
