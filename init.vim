"""
"""
""" GLOBAL EDITOR OPTIONS
"""
"""

"   show line numbers
set number

"   use space tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set completeopt+=noselect

"   current working directory
autocmd BufEnter * lcd %:p:h

"""
""" CUSTOM KEYBINDS
"""
nnoremap H gT
nnoremap L gt
"   tab completion with deoplete
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""
"""
""" PLUGIN CONFIGURATION
"""
"""

call plug#begin('~/.config/nvim/plugged')

"""
""" WINDOW PLUGINS
"""

""" NERDTree
Plug 'scrooloose/nerdtree'
"   git flags support
Plug 'Xuyuanp/nerdtree-git-plugin'
"   basic options
let g:NERDTreeWinSize = 50
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

"""
""" DEVELOPMENT PLUGINS
"""

""" CODE COMPLETION
""" using deoplete.nvim

"   requires python package 'pynvim'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
"   launch deoplete at startup
let g:deoplete#enable_at_startup = 1

""  use denite
if has('nvim')
    Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/denite.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
"   disable buffer and around source for auto-completion
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'around']

""  define completion sources
"   golang
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }
let g:deoplete#sources#go#gocode_binary = '$GOPATH/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#pointer = 1
" let g:deoplete#sources#go#source_importer = 1
let g:deoplete#sources#go#builtin_objects = 1
let g:deoplete#sources#go#unimported_packages = 1
"   include
Plug 'Shougo/neoinclude.vim'
"   python
Plug 'deoplete-plugins/deoplete-jedi'
"   rust
"   the default key mappings:
"       nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
"       nmap <buffer> K  <plug>DeopleteRustShowDocumentation
Plug 'sebastianmarkow/deoplete-rust'
"   typescript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
"   vimscript
Plug 'Shougo/neco-vim'

""" auto pairs
Plug 'jiangmiao/auto-pairs'

""" SNIPPETS
""" using neosnippet

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"   use C-k to select snippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"   supertab behavior
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\   "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"   conceal markers
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

""" LINTING
""" using Asynchronous Lint Engine

Plug 'dense-analysis/ale'
""  define linters
let g:ale_linters = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['golint'],
\   'typescript': ['prettier', 'tslint'],
\   'markdown': ['proselint', 'textlint'],
\   'rust': ['rls'],
\}
"   show warnings in statusline
let g:airline#extensions#ale#enabled = 1

""" FORMATTING
""" using neoformat
Plug 'sbdchd/neoformat'
"   auto-format on save
augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END
"   define formatters
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neofromat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_markdown = ['']

""" editorconfig
Plug 'editorconfig/editorconfig-vim'

""" nerdcommenter
"   comment/uncomment with keybindings
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1

""" tabularize
Plug 'godlygeek/tabular'
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction


"""
"""  LANGUAGE PLUGINS
"""

""" golang
Plug 'fatih/vim-go'
let g:go_code_completion_enabled = 1
let g:go_auto_type_info = 1
let g:go_fmt_autosave = 1
let g:go_def_mapping_enabled = 1
let g:go_snippet_engine = "automatic"
let g:go_autodetect_gopath = 1
let g:go_gocode_propose_source = 1

""" graphql
Plug 'jparise/vim-graphql'

""" i3 config
Plug 'mboughaba/i3config.vim'
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

""" pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

""" csv
Plug 'mechatroner/rainbow_csv'

"""
""" NAVIGATION PLUGINS
"""
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"""
""" THEME PLUGINS
"""
"   gruvbox
Plug 'morhetz/gruvbox'
"   oceanic-next
Plug 'mhartington/oceanic-next'
"   nordisk
Plug 'kamwitsta/nordisk'
"   forest-night
Plug 'sainnhe/vim-color-forest-night'
"   desert-night
Plug 'sainnhe/vim-color-desert-night'
"   seiya transparency
Plug 'miyakogi/seiya.vim'

"   end plugin check/installation
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""
"""
""" THEME
"""
"""

"   enable termguicolors
set termguicolors
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
"   use gruvbox theme
colorscheme gruvbox
