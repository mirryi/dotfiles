local lib = require('lib')

pkg.name = 'eww'
pkg.dependencies:extend('../sh')

pkg.files.trees:front().ignore:extend('**/*.hbs')
pkg.files.templates:extend({
    src = 'tree/.config/eww/eww.scss.hbs',
    dest = '.config/eww/eww.scss',
    engine = 'handlebars',
})

local home = os.getenv('HOME')
pkg.hooks.post:extend {
    name = 'Reload eww',
    command = home .. '/.local/bin/launch-eww',
}

-- Reuse the polybar profile palette/font; both gruvbox profiles already
-- define it, so there is one source of truth for the theme.
lib.use_profile('polybar')

-- Load local file if it exists
lib.require_opt('local')
