local lib = require('lib')

pkg.name = 'igrep'
pkg.dependencies:extend('../sh')

pkg.files.trees:clear()
pkg.files.templates:push {
    src = 'rc/rc.hbs',
    dest = '.config/sh/load/igrep/rc',
    engine = 'handlebars',
}

lib.use_profile('igrep')

-- Load local file if exists
lib.require_opt('local')
