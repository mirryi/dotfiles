"   begin plugin check/installation
call plug#begin(nvim_data . '/plugged')

"""
""" NAVIGATION
"""

""" tmux-focus-events
Plug 'tmux-plugins/vim-tmux-focus-events'
""" fzf
Plug 'junegunn/fzf.vim'
""" ranger
Plug 'rafaqz/ranger.vim'


"""
""" WINDOW
"""

Plug 'nvim-lua/lsp-status.nvim'
""" airline
Plug 'vim-airline/vim-airline'
"   airline themes
Plug 'vim-airline/vim-airline-themes'
""" gitgutter
Plug 'airblade/vim-gitgutter'


"""
""" CODE COMPLETION
"""

""" nvim-lsp
Plug 'neovim/nvim-lsp'
""" completion-nvim
Plug 'nvim-lua/completion-nvim'
""" diagnostic-nvim
Plug 'nvim-lua/diagnostic-nvim'
""" delimitMate (autoclose parentheses, etc.)
Plug 'Raimondi/delimitMate'
""" vim-closetag (autoclose XHTML tags)
Plug 'alvan/vim-closetag'
""" import-js (import js dependencies)
Plug 'galooshi/vim-import-js', { 'for': 'javascript' }


"""
""" SNIPPETS
"""

""" neosnippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'


"""
""" LINTING
"""

""" Asynchronous Lint Engine (ALE)
" Plug 'dense-analysis/ale'


"""
""" FORMATTING
"""

""" neoformat
Plug 'sbdchd/neoformat'
""" nerdcommenter
"   comment/uncomment with keybindings (\ + c + <space>)
Plug 'scrooloose/nerdcommenter'
""" tabularize
Plug 'godlygeek/tabular'


"""
""" LANGUAGE
"""

""" polyglot (covers most languages)
Plug 'sheerun/vim-polyglot'
""" arduino
Plug 'stevearc/vim-arduino'
""" csv
Plug 'mechatroner/rainbow_csv'
""" editorconfig
Plug 'editorconfig/editorconfig-vim'
""" golang
Plug 'fatih/vim-go'
""" jsonc
Plug 'kevinoid/vim-jsonc'
""" pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
""" postgresql
Plug 'lifepillar/pgsql.vim'
""" rmarkdown
Plug 'vim-pandoc/vim-rmarkdown'
""" vimtex
" Plug 'lervag/vimtex'
""" cxx semantic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'
""" thesaurus
Plug 'ron89/thesaurus_query.vim'


"""
""" THEME
"""

"   gruvbox-material
Plug 'sainnhe/gruvbox-material'
"   nord
Plug 'arcticicestudio/nord-vim'
"   terminal colors
" Plug 'dylanaraps/wal.vim'

"   end plugin check/installation
call plug#end()
