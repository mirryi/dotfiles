augroup start
  autocmd BufCreate * stopinsert
augroup END

" Load main configuration
lua require 'init'

" Load vimscript files
execute 'source' . stdpath('config') . '/macros.vim'
