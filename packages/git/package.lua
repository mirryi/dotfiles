local lib = require('lib')

pkg.name = 'git'
pkg.dependencies:extend('../sh')

pkg.files.extra:push { src = 'config.local', dest = '.config/git/config.local' }

pkg.files.trees:front().ignore:extend('**/*.hbs')
pkg.files.templates:push {
    src = 'tree/.config/git/config.delta.hbs',
    dest = '.config/git/config.delta',
    engine = 'handlebars',
}

lib.use_profile('git')

-- Load local file if exists
lib.require_opt('local')
