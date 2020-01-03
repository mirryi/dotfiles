""" NAVIGATION/WINDOWS

""" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

""" NERDTree
Plug 'scrooloose/nerdtree'
"   git flags support
Plug 'Xuyuanp/nerdtree-git-plugin'
"   basic options
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1
"   start automatically if no files are specified
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter *
\       if (argc() == 0 && !exists("s:std_in")) |
\           NERDTree |
\       endif
"   start automatically when opening a directory
autocmd VimEnter *
\       if (argc() == 1 && isdirectory(argv()[0]) &&
\           !exists("s:std_in")) |
\           exe 'NERDTree' argv()[0] |
\           wincmd p |
\           ene |
\           exe 'cd '.argv()[0] |
\       endif
"   close vim if only tree is left open
autocmd bufenter *
\       if (winnr("$") == 1 &&
\           exists("b:NERDTree") &&
\           b:NERDTree.isTabTree()) |
\           q |
\       endif

""" airline
Plug 'vim-airline/vim-airline'
"   themes
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'minimalist'

""" gitgutter
Plug 'airblade/vim-gitgutter'
let g:gitgutter_max_signs = 1000

