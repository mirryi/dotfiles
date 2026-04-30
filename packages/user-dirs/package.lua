local lib = require('lib')

pkg.name = 'user-dirs'

pkg.files.trees:clear()
pkg.files.templates:extend {
    src = 'config/user-dirs.dirs.hbs',
    dest = '.config/user-dirs.dirs',
    engine = 'handlebars',
}

lib.use_variables()

-- Load local file if it exists
lib.require_opt('local')
