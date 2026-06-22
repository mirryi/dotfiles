local lib = require('lib')

pkg.name = 'nix'

-- Load local file if exists
lib.require_opt('local')
