local lib = require('lib')

pkg.name = 'dev'

pkg.files.trees:clear()
for _, dir in ipairs(lib.list_dirs('.')) do
    if dir ~= 'lib' then
        pkg.dependencies:extend(dir)
    end
end
