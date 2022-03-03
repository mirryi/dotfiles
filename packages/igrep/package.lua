local lib = require('lib')

pkg.name = 'igrep'
pkg.dependencies:extend('../sh')

-- Load local file if exists
lib.require_opt('local')
