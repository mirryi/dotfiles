local lib = require('lib')

pkg.name = 'gtk'
pkg.dependencies:extend('../sh')

pkg.files.trees:clear()
pkg.files.templates:push {
    src = 'config/env.hbs',
    dest = '.config/sh/load/gtk/env',
    engine = 'handlebars',
}

local profile = require('profile').gtk
pkg.variables:overwrite(profile)

-- Load local file if exists
lib.require_opt('local')
