local lib = require('lib')

pkg.name = 'gtk'
pkg.dependencies:extend('../sh')

local themes = { 'gruvbox-gtk' }
local theme_files = functional.map(themes, function(v)
    return {
        src = 'themes/' .. v,
        dest = '.local/share/themes/' .. v,
        replace_dirs = true,
    }
end)

pkg.files.extra:extend(table.unpack(theme_files))

local profile = require('profile').gtk
pkg.files.extra:push {
    src = 'themes/' .. profile.theme,
    dest = '.local/share/themes/current-theme',
    replace_dirs = true,
}

-- Load local file if exists
lib.require_opt('local')
