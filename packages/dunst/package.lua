local lib = require('lib')

pkg.name = 'dunst'

pkg.files.trees:clear()
pkg.files.templates:push {
    src = 'config/dunstrc.ini.hbs',
    dest = '.config/dunst/dunstrc',
    engine = 'handlebars',
}

pkg.hooks.post:push { name = 'Restart dunst', command = 'hooks/dunst-restart.sh' }

lib.use_profile('dunst')

-- Load local config if exists
lib.require_opt('local')
