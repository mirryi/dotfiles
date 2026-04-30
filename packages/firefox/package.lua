local lib = require('lib')

pkg.name = 'firefox'

if lib.file_exists('local/bookmarks') then
    pkg.files.extra:extend {
        src = 'local/bookmarks',
        dest = '.config/tridactyl/bookmarks',
    }
end

-- Load local file if it exists
lib.require_opt('local')
