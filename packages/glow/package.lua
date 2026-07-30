local lib = require('lib')

pkg.name = 'glow'

pkg.files.trees:clear()
pkg.files.templates:push {
    src = 'config/glow.hbs',
    dest = '.config/glow/glow.yml',
    engine = 'handlebars',
}

lib.use_profile('glow')

-- Load local file if it exists
lib.require_opt('local')
