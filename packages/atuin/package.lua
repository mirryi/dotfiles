local lib = require('lib')

pkg.name = 'atuin'

-- Shell init lives in the zsh package (eval "$(atuin init zsh)"); this package
-- only ships the config.

-- Load local file if exists
lib.require_opt('local')
