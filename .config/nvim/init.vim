let nvim_data = $XDG_DATA_HOME . "/nvim"
let nvim_cache = $XDG_CACHE_HOME . "/nvim"

"   begin plugin check/installation
call plug#begin(nvim_data . '/plugged')

"""
""" GLOBAL EDITOR OPTIONS
"""
"   source local .vimrc files
set exrc
set secure

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
let &undodir=nvim_cache . "/undo"
"   current working directory
autocmd BufEnter * lcd %:p:h

" set vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"""
""" CUSTOM KEYBINDS
"""

""" map leader
let mapleader=","

""" change tabs
"   focus tab left
nnoremap H gT
"   focus tab right
nnoremap L gt

"""
""" NAVIGATION
"""

""" fzf
Plug 'junegunn/fzf.vim'

""" netwr
let g:netrw_home = nvim_cache

""" NERDTree
Plug 'scrooloose/nerdtree'
"   git flags support
Plug 'Xuyuanp/nerdtree-git-plugin'
"   basic options
let g:NERDTreeWinSize = 36
let g:NERDTreeShowHidden = 1
"   git indicator symbols
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "~",
      \ "Staged"    : "+",
      \ "Untracked" : "_",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : '☒',
      \ "Unknown"   : "?"
      \ }
"   open NERDTree with key bind
map <C-n> :NERDTreeToggle<CR>
"   start automatically if no files are specified
" autocmd VimEnter * NERDTree
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter *
      \   if (argc() == 0 && !exists("s:std_in")) |
      \     NERDTree |
      \   endif
"   start automatically when opening a directory
autocmd VimEnter *
      \   if (argc() == 1 && isdirectory(argv()[0]) &&
      \     !exists("s:std_in")) |
      \     exe 'NERDTree' argv()[0] |
      \     wincmd p |
      \     ene |
      \     exe 'cd '.argv()[0] |
      \     wincmd p |
      \   endif
"   close vim if only tree is left open
autocmd bufenter *
      \   if (winnr("$") == 1 &&
      \     exists("b:NERDTree") &&
      \     b:NERDTree.isTabTree()) |
      \     q |
      \   endif

"""
""" WINDOW
"""


""" airline
Plug 'vim-airline/vim-airline'
"   themes
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

""" gitgutter
Plug 'airblade/vim-gitgutter'
let g:gitgutter_max_signs = 1000

"""
""" CODE COMPLETION
"""

""" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}
"   css, scss, less
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
"   html, handlebars, razor
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
"   java (using eclipse.jdt.ls)
Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}
"   json
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
"   python
" Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
"   rust (using rls)
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
"   R
Plug 'neoclide/coc-r-lsp', {'do': 'yarn install --frozen-lockfile'}
"   latex (with vimtex)
"   does not work, use :CocInstall coc-vimtex
" Plug 'neoclide/coc-vimtex', {'do': 'yarn install --frozen-lockfile'}
"   typescript, javascript (using tsserver)
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
"   vimscript (using viml)
"   does not work, use :CocInstall coc-vimlsp
" Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
"   yaml
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
"   xml
Plug 'fannheyward/coc-xml', {'do': 'yarn install --frozen-lockfile'}
"   zsh
Plug 'tjdevries/coc-zsh'

"   tab trigger for completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"   use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

"   use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

"   highlight symbol under cursor on CursorHold
set updatetime=300
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

"   use `rn` to rename current symbol
nmap <leader>rn <Plug>(coc-rename)

"   remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""" delimitMate (autoclose parentheses, etc.)
Plug 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 2
""" vim-closetag (autoclose XHTML tags)
Plug 'alvan/vim-closetag'
let g:closetag_filetypes = 'html,xhtml,phtml,javascriptreact,typescriptreact'

""" import-js (import js dependencies)
Plug 'galooshi/vim-import-js'

"""
""" SNIPPETS
"""

""" neosnippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"   use :CocInstall coc-neosnippet
"   use C-k to select snippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"   supertab behavior
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \   "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"""
""" LINTING
"""

""" Asynchronous Lint Engine (ALE)
Plug 'dense-analysis/ale'
""  define linters
let g:ale_linters = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'cpp': ['ccls'],
      \   'go': ['golint'],
      \   'html': ['prettier'],
      \   'typescript': ['prettier', 'tslint'],
      \   'markdown': ['proselint', 'textlint'],
      \   'rust': ['rls'],
      \}
"   show warnings in statusline
let g:airline#extensions#ale#enabled = 1

""" cSpell (using coc.nvim)
"   does not work, use :CocInstall coc-spell-checker
" Plug 'iamcco/coc-spell-checker', {'do': 'yarn install --frozen-lockfile'}

"""
""" FORMATTING
"""

""" neoformat
Plug 'sbdchd/neoformat'
"   auto-format on save
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
"   default formatting
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
"   define formatters
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neofromat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_markdown = ['']

let g:neofromat_sql_pg_format = {
  \ 'exe': 'pg_format',
  \ 'args': ['-m 90', '-s 2'],
  \ }
let g:neoformat_enabled_sql = ['pg_format']

""" nerdcommenter
"   comment/uncomment with keybindings (\ + c + <space>)
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1

""" tabularize
Plug 'godlygeek/tabular'
"   auto-align when using pipe key to make table
inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a
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
""" LANGUAGE
"""

""" polyglot (covers most languages)
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['latex']

""" arduino
Plug 'stevearc/vim-arduino'

""" csv
Plug 'mechatroner/rainbow_csv'

""" editorconfig
Plug 'editorconfig/editorconfig-vim'

""" golang
""" vim-go with coc.vim
Plug 'fatih/vim-go'
let g:go_code_completion_enabled = 1
let g:go_auto_type_info = 1
let g:go_fmt_autosave = 1
let g:go_def_mapping_enabled = 1
let g:go_snippet_engine = "automatic"
let g:go_autodetect_gopath = 1
let g:go_gocode_propose_source = 1
"   disable vim-go :GoDef short cut (gd)
"   this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

""" jsonc
Plug 'kevinoid/vim-jsonc'

""" pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#modules#disabled = ['folding', 'spell']
" let g:pandoc#filetypes#pandoc_markdown = 0

""" postgresql
Plug 'lifepillar/pgsql.vim'
let g:sql_type_default = 'pgsql'

""" vimtex
Plug 'lervag/vimtex'

""" cxx semantic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'

"""
""" THEME
"""

"   gruvbox
Plug 'morhetz/gruvbox'
"   gruvbox-material
Plug 'sainnhe/gruvbox-material'
"   oceanic-next
Plug 'mhartington/oceanic-next'
"   nordisk
Plug 'kamwitsta/nordisk'
"   forest-night
Plug 'sainnhe/vim-color-forest-night'
"   seiya transparency
Plug 'miyakogi/seiya.vim'

"   end plugin check/installation
call plug#end()

"   enable termguicolors
set termguicolors
"   use gruvbox theme
set background=dark
let g:gruvbox_material_background = "medium"
" let g:airline_theme = 'base16_gruvbox_dark_hard'
let g:airline_theme = 'zenburn'
colorscheme gruvbox-material

