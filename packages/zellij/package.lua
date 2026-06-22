local lib = require('lib')

pkg.name = 'zellij'
pkg.dependencies:extend('../sh')

pkg.files.templates:push {
    src = 'config/config.kdl.hbs',
    dest = '.config/zellij/config.kdl',
    engine = 'handlebars',
}
pkg.files.templates:push {
    src = 'config/layouts/default.kdl.hbs',
    dest = '.config/zellij/layouts/default.kdl',
    engine = 'handlebars',
}

lib.use_profile('zellij')
lib.require_opt('local')
