-- luacheck: globals pkg
local lib = require('lib')

pkg.name = 'alacritty'
pkg.dependencies:extend('../qt')

pkg.files.trees:clear()
pkg.files.templates:push {
    src = 'config/alacritty.toml.hbs',
    dest = '.config/alacritty/alacritty.toml',
    engine = 'handlebars',
    partials = {
        common = 'config/common.toml',
        profile = 'config/profile.toml.hbs',
    },
}

local profile = require('profile').alacritty
pkg.variables:overwrite(profile)

-- Load local file if it exists
lib.require_opt('local')
