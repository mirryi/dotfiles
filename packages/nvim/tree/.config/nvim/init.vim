" Load main configuration
lua require 'init'

" Load vimscript files
execute 'source' . luaeval('require("core.paths").config') . '/macros.vim'
