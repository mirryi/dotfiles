local lib = require('lib')
local lfs = require('lfs')

pkg.name = 'firefox'

if lfs.attributes('local/bookmarks') then
    pkg.files.extra:extend {
        src = 'local/bookmarks',
        dest = '.config/tridactyl/bookmarks',
    }
end

-- Load local file if it exists
lib.require_opt('local')
