local lib = require('lib')

pkg.name = 'yazi'
pkg.dependencies:extend('../sh')

pkg.files.templates:push {
    src = 'config/theme.toml.hbs',
    dest = '.config/yazi/theme.toml',
    engine = 'handlebars',
}

pkg.files.templates:push {
    src = 'config/yazi.toml.hbs',
    dest = '.config/yazi/yazi.toml',
    engine = 'handlebars',
    partials = {
        common = 'config/common.toml',
        open = 'config/open.toml',
    },
}

pkg.hooks.post:push { name = 'Install yazi plugins', command = 'hooks/install-plugins.sh' }

lib.use_profile('yazi')

-- Load local file if exists
lib.require_opt('local')
