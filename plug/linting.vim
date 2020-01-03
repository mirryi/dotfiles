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

