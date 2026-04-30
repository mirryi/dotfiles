local lib = require('lib')

pkg.name = 'rofi'

pkg.files.trees:front().ignore:extend('**/*.hbs')
pkg.files.templates:extend {
    src = 'tree/.config/rofi/config.rasi.hbs',
    dest = '.config/rofi/config.rasi',
    engine = 'handlebars',
}

lib.use_profile('rofi')

-- Load local file if it exists
lib.require_opt('local')
