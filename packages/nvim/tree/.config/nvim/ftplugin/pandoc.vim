"   tab size
set tabstop=4
set shiftwidth=4
set expandtab

""  vim-pandoc
let g:pandoc#modules#disabled = ['folding', 'spell']
" let g:pandoc#filetypes#pandoc_markdown = 0

""  delimitMate
let b:delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_quotes = "\" ` * _"

""  tagbar
let g:tagbar_type_pandoc = {
  \ 'ctagstype': 'markdown',
  \ 'ctagsbin' : g:nvim_config . '/scripts/markdown2ctags.py',
  \ 'ctagsargs' : '-f - --sort=yes --sro=»',
  \ 'kinds' : [
      \ 's:sections',
      \ 'i:images'
  \ ],
  \ 'sro' : '»',
  \ 'kind2scope' : {
      \ 's' : 'section',
  \ },
  \ 'sort': 0,
\}

""  tabular
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
