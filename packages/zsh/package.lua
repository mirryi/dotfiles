local lib = require('lib')

pkg.name = 'zshrc'
pkg.dependencies:extend('../atuin')

-- Load local file if it exists
lib.require_opt('local')
