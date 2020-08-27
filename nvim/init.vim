let nvim_config = $XDG_CONFIG_HOME . "/nvim"
let nvim_data = $XDG_DATA_HOME . "/nvim"
let nvim_cache = $XDG_CACHE_HOME . "/nvim"

"""
""" PLUGINS
"""
"   load plugins
exec "source " . nvim_config . "/plugins.vim"

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
" let mapleader=","

""" change tabs
"   focus tab left
nnoremap H gT
"   focus tab right
nnoremap L gt


"""
""" NAVIGATION
"""

""" netwr
let g:netrw_home = nvim_cache

""" ranger
map <leader>rr :RangerEdit<cr>
map <leader>rv :RangerVSplit<cr>
map <leader>rs :RangerSplit<cr>
map <leader>rt :RangerTab<cr>
map <leader>ri :RangerInsert<cr>
map <leader>ra :RangerAppend<cr>
map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
map <leader>rd :RangerCD<cr>
map <leader>rld :RangerLCD<cr>


"""
""" WINDOW
"""

""" lsp-status.nvim
function! LspWarnStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval('require("lsp").warning_status()')
  endif
  return ''
endfunction

function! LspErrorStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval('require("lsp").error_status()')
  endif
  return ''
endfunction

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
""  append lsp-status
function! AirlineInit()
  call airline#parts#define_function('lsp-warn-status', 'LspWarnStatus')
  call airline#parts#define_function('lsp-error-status', 'LspErrorStatus')
  let g:airline_section_warning = airline#section#create_right(['lsp-warn-status'])
  let g:airline_section_error = airline#section#create_right(['lsp-error-status'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

""" gitgutter
let g:gitgutter_max_signs = 1000


"""
""" CODE COMPLETION
"""

""" nvim-lsp
lua require("lsp")

""" completion-nvim
"   enable snippet support
let g:completion_enable_snippet = 'Neosnippet'
"   use tab for completion menu navigation
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect

""" diagnostic-nvim
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1

""" delimitMate
let g:delimitMate_expand_cr = 2

""" vim-closetag
let g:closetag_filetypes = 'html,xhtml,phtml,javascriptreact,typescriptreact'
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_close_shortcut = '<leader>>'


"""
""" SNIPPETS
"""

""" neosnippet
"   use C-k to select snippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"   supertab behavior
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


"""
""" LINTING
"""

""" ale
""  define linters
let g:ale_linters = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'cpp': ['ccls'],
  \   'go': ['golint'],
  \   'html': ['prettier'],
  \   'typescript': ['prettier', 'eslint'],
  \   'typescriptreact': ['prettier', 'eslint'],
  \   'markdown': ['proselint', 'textlint'],
  \   'pandoc': ['proselint', 'textlint'],
  \   'rust': ['rls'],
  \}
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'typescript': ['prettier', 'eslint'],
  \   'typescriptreact': ['prettier', 'eslint'],
  \   'scss': ['stylelint'],
  \}
let g:ale_fix_on_save = 1
"   show warnings in statusline
let g:airline#extensions#ale#enabled = 1


"""
""" FORMATTING
"""

""" neoformat
"   auto-format on save
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
""  default formatting
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
""  define formatters
"   javascript / typescript / react stuff
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']
let g:neoformat_typescriptreact_prettier = {
  \ 'exe': 'prettier',
  \ 'args': ['--stdin', '--stdin-filepath', '"%:p"'],
  \ 'stdin': 1,
  \ }
"   lua
let g:neoformat_enabled_lua = ['luaformat']
let g:neoformat_lua_luaformat = {
  \ 'exe': 'lua-format',
  \ 'stdin': 1,
  \ }
"   markdown
let g:neoformat_enabled_markdown = ['']
"   pg sql
let g:neofromat_sql_pg_format = {
  \ 'exe': 'pg_format',
  \ 'args': ['-m 90', '-s 2'],
  \ }
"   sql
let g:neoformat_enabled_sql = ['pg_format']
"   rust
let g:neoformat_enabled_rust = ['rustfmt']

""" nerdcommenter
let g:NERDSpaceDelims = 1

""" tabular
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

""" vim-polyglot
let g:polyglot_disabled = ['latex']

""" vim-go
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

" vim-pandoc
let g:pandoc#modules#disabled = ['folding', 'spell']
" let g:pandoc#filetypes#pandoc_markdown = 0

""" pgsql.vim
let g:sql_type_default = 'pgsql'

""" thesaurus_query.vim
let g:tq_map_keys = 0
nnoremap <leader>t :ThesaurusQueryReplaceCurrentWord<CR>



"   enable termguicolors
set termguicolors

exec "source " . nvim_config . '/theme.vim'


"""
""" CUSTOM MACROS / FUNCTIONS
"""

""" Word frequency calculation

" Sorts numbers in ascending order.
" Examples:
" [2, 3, 1, 11, 2] --> [1, 2, 2, 3, 11]
" ['2', '1', '10','-1'] --> [-1, 1, 2, 10]
function! Sorted(list)
  " Make sure the list consists of numbers (and not strings)
  " This also ensures that the original list is not modified
  let nrs = ToNrs(a:list)
  let sortedList = sort(nrs, "NaturalOrder")
  echo sortedList
  return sortedList
endfunction

" Comparator function for natural ordering of numbers
function! NaturalOrder(firstNr, secondNr)
  if a:firstNr < a:secondNr
    return -1
  elseif a:firstNr > a:secondNr
    return 1
  else
    return 0
  endif
endfunction

" Coerces every element of a list to a number. Returns a new list without
" modifying the original list.
function! ToNrs(list)
  let nrs = []
  for elem in a:list
    let nr = 0 + elem
    call add(nrs, nr)
  endfor
  return nrs
endfunction

function! WordFrequency() range
  " Words are separated by whitespace or punctuation characters
  let wordSeparators = '[[:blank:][:punct:]]\+'
  let allWords = map(split(join(getline(a:firstline, a:lastline)), wordSeparators), {_, val -> tolower(val)})
  let wordToCount = {}
  for word in allWords
    let wordToCount[word] = get(wordToCount, word, 0) + 1
  endfor

  let countToWords = {}
  for [word,cnt] in items(wordToCount)
    let words = get(countToWords,cnt,"")
    " Append this word to the other words that occur as many times in the text
    let countToWords[cnt] = words . " " . word
  endfor

  " Create a new buffer to show the results in
  new
  setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20

  " List of word counts in ascending order
  let sortedWordCounts = Sorted(keys(countToWords))

  call append("$", "count \t words")
  call append("$", "--------------------------")
  " Show the most frequent words first -> Descending order
  for cnt in reverse(sortedWordCounts)
    let words = countToWords[cnt]
    call append("$", cnt . "\t" . words)
  endfor
endfunction

command! -range=% WordFrequency <line1>,<line2>call WordFrequency()

function! Mirror(dict)
    for [key, value] in items(a:dict)
        let a:dict[value] = key
    endfor
    return a:dict
endfunction

function! S(number)
    return submatch(a:number)
endfunction

function! SwapWords(dict, ...)
    let words = keys(a:dict) + values(a:dict)
    let words = map(words, 'escape(v:val, "|")')
    if(a:0 == 1)
        let delimiter = a:1
    else
        let delimiter = '/'
    endif
    let pattern = '\v(' . join(words, '|') . ')'
    exe '%s' . delimiter . pattern . delimiter
        \ . '\=' . string(Mirror(a:dict)) . '[S(0)]'
        \ . delimiter . 'g'
endfunction
