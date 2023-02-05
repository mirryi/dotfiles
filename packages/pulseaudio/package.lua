-- luacheck: globals pkg
local lib = require('lib')

pkg.name = 'pulseaudio'

-- Load local file if exists
lib.require_opt('local')
