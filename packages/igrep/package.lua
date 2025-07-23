local lib = require('lib')

pkg.name = 'igrep'
pkg.dependencies:extend('../sh')

pkg.files.trees:clear()
pkg.files.templates:push {
    src = 'rc/rc.hbs',
    dest = '.config/sh/load/igrep/rc',
    engine = 'handlebars',
}

local profile = require('profile').igrep
pkg.variables:overwrite(profile)

-- Load local file if exists
lib.require_opt('local')
