local lib = require('lib')

pkg.name = 'i3'
pkg.dependencies:extend('../eww', '../wallpaper', '../dunst', '../rofi')

local partials = {
    common = 'config/common.i3config',
    profile = 'config/profile.i3config.hbs',
}
if lib.file_exists('config/local.i3config.hbs') then
    partials.lcl = 'config/local.i3config.hbs'
end

pkg.files.templates:push {
    src = 'config/config.i3config.hbs',
    dest = '.config/i3/config',
    engine = 'handlebars',
    partials = partials,
}

pkg.hooks.post.push { name = 'Reload i3', command = 'hooks/reload-i3.sh' }

lib.use_profile('i3')
lib.use_variables()

-- Load local file if it exists
lib.require_opt('local')
