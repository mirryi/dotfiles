local lib = require('lib')

pkg.name = 'bat'

pkg.files.trees:clear()
pkg.files.templates:push {
    src = 'config/config.hbs',
    dest = '.config/bat/config',
    engine = 'handlebars',
}

lib.use_profile('bat')

-- Load local file if it exists
lib.require_opt('local')
