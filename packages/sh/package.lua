local lib = require('lib')

pkg.name = 'sh'

if lib.file_exists('local.sh') then
    pkg.files.extra:extend {
        src = 'local.sh',
        dest = '.config/sh/load/local',
        replace_dirs = true,
    }
end

-- Load local file if it exists
lib.require_opt('local')
