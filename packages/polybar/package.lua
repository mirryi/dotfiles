local lib = require('lib')

pkg.name = 'polybar'
pkg.dependencies:extend('../sh')

pkg.files.trees:front().ignore:extend('**/*.hbs')
pkg.files.templates:extend({
    src = 'tree/.config/polybar/settings.ini.hbs',
    dest = '.config/polybar/settings.ini',
    engine = 'handlebars',
}, {
    src = 'tree/.config/polybar/modules/network.ini.hbs',
    dest = '.config/polybar/modules/network.ini',
    engine = 'handlebars',
})

local home = os.getenv('HOME')
pkg.hooks.post:extend {
    name = 'Reload polybar',
    command = home .. '/.local/bin/launch-polybar',
}

local profile = require('profile').polybar
pkg.variables:overwrite(profile)

local lcl = require('variables')

local network = lcl.network
if network == nil then
    network = { interface = '', type = '' }
end
pkg.variables.network = network

local map_bars = function(bar)
    return {
        left = table.concat(bar.left, ' '),
        center = table.concat(bar.center, ' '),
        right = table.concat(bar.right, ' '),
    }
end

pkg.variables.modules = {
    top = map_bars(lcl.modules.top),
    bottom = map_bars(lcl.modules.bottom),
}

-- Load local file if it exists
lib.require_opt('local')
