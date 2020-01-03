"""
"""
""" PLUGIN CONFIGURATION
"""
"""

call plug#begin('~/.config/nvim/plugged')

for fpath in split(globpath(stdpath("config") . "/plug", "*.vim"), "\n")
    exe 'source' fpath
endfor

"   end plugin check/installation
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""
"""
""" GLOBAL EDITOR OPTIONS
"""
"""

"   hidden
set hidden

"   show line numbers
set number

"   default no softwrap
set nowrap

"   use space tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"   better display for messages
set cmdheight=2

"   avoid hit-enter messages
set shortmess+=c

"   always show signcolumns
set signcolumn=yes

"   maintain undo history between sessions
set undofile
let &undodir=stdpath("config") . "/undo"

"   current working directory
autocmd BufEnter * lcd %:p:h

"""
""" CUSTOM KEYBINDS
"""
nnoremap H gT
nnoremap L gt

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""
"""
""" THEME
"""
"""

"   enable termguicolors
set termguicolors
"   use gruvbox theme
colorscheme gruvbox
