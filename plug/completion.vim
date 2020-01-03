""" CODE COMPLETION
""" using coc.nvim

Plug 'neoclide/coc.nvim', {'branch': 'release'}
"   css, scss, less
Plug 'neoclide/coc-css'
"   html, handlebars, razor
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
"   java (using eclipse.jdt.ls)
Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}
"   json
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
"   python
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
"   rust (using rls)
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
"   typescript, javascript (using tsserver)
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
"   vimscript (using viml)
"   does not work, use :CocInstall coc-vimlsp
" Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
"   yaml
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
"   xml
Plug 'fannheyward/coc-xml', {'do': 'yarn install --frozen-lockfile'}

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
"   remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""" using deoplete.nvim

" "   requires python package 'pynvim'
" if has('nvim')
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
    " Plug 'Shougo/deoplete.nvim'
    " Plug 'roxma/nvim-yarp'
    " Plug 'roxma/vim-hug-neovim-rpc'
" endif
" "   launch deoplete at startup
" let g:deoplete#enable_at_startup = 1

" ""  use denite
" if has('nvim')
    " Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" else
    " Plug 'Shougo/denite.nvim'
    " Plug 'roxma/nvim-yarp'
    " Plug 'roxma/vim-hug-neovim-rpc'
" endif
" "   disable buffer and around source for auto-completion
" let g:deoplete#ignore_sources = {}
" let g:deoplete#ignore_sources._ = ['buffer', 'around']

"   tab completion
" function! s:check_back_space() abort "{{{
  " let col = col('.') - 1
  " return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ deoplete#manual_complete()

" ""  define completion sources
" "   golang
" Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }
" let g:deoplete#sources#go#gocode_binary = '$GOPATH/bin/gocode'
" let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" let g:deoplete#sources#go#pointer = 1
" let g:deoplete#sources#go#source_importer = 1
" let g:deoplete#sources#go#builtin_objects = 1
" let g:deoplete#sources#go#unimported_packages = 1
" "   include
" Plug 'Shougo/neoinclude.vim'
" "   python
" Plug 'deoplete-plugins/deoplete-jedi'
" "   rust
" "   the default key mappings:
" "       nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
" "       nmap <buffer> K  <plug>DeopleteRustShowDocumentation
" Plug 'sebastianmarkow/deoplete-rust'
" "   typescript
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" "   vimscript
" Plug 'Shougo/neco-vim'

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
