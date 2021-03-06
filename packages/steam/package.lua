local lib = require('lib')

pkg.name = 'steam'
pkg.dependencies:extend('../sh')

pkg.hooks.post:extend {
    name = 'Install metro-for-steam',
    command = 'hooks/install-metro.sh',
}

-- Load local file if it exists
lib.require_opt('local')
