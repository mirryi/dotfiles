local lib = require('lib')

pkg.name = 'claude'
pkg.dependencies:extend('../../sh')

pkg.files.trees:front().ignore:extend('**/*.hbs')
pkg.files.templates:extend {
    src = 'tree/.config/claude/statusline-command.sh.hbs',
    dest = '.config/claude/statusline-command.sh',
    engine = 'handlebars',
}

-- Statusline colors come from the claude profile section, so the theme has
-- one source of truth.
lib.use_profile('claude')

-- Load local file if exists
lib.require_opt('local')
