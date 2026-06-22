local lib = require('lib')

pkg.name = 'eww'
pkg.dependencies:extend('../sh')

pkg.files.trees:front().ignore:extend('**/*.hbs')
pkg.files.templates:extend {
    src = 'tree/.config/eww/eww.scss.hbs',
    dest = '.config/eww/eww.scss',
    engine = 'handlebars',
}

local home = os.getenv('HOME')
pkg.hooks.post:extend {
    name = 'Reload eww',
    command = home .. '/.local/bin/launch-eww',
}

-- Palette/font come from the eww profile section, so the theme has one
-- source of truth.
lib.use_profile('eww')

-- Load local file if it exists
lib.require_opt('local')
