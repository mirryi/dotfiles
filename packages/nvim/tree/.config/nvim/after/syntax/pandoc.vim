" vim-pandoc-syntax ships no `syn sync` directive, so redraw cost grows with
" cursor depth into the buffer; bound it instead of using Vim's default.
syn sync minlines=100

syn match pandocWikiLink /\[\[[^][\n]*\]\]/ display
syn match pandocWikiLinkBracket /\[\[\|\]\]/ contained containedin=pandocWikiLink conceal display

" bounded with \{-,N}, not *: an unbounded class before a required literal
" backtracks catastrophically on long lines with no closing "|" (e.g. a bare
" [[link]] with no title)
syn match pandocWikiLinkTarget /\%(\[\[\)\@2<=[^][|]\{-,100}|/ contained containedin=pandocWikiLink conceal display

syn match pandocSimpleCiteBracket /[\[\]]/ contained containedin=pandocPCite,pandocICite conceal display
syn match pandocCiteTail /[[:alnum:]_]\@1<=[[:upper:][:digit:]][[:alnum:]_:.#$%&+?<>~-]*/ contained containedin=pandocCiteKey conceal display

hi def link pandocWikiLink pandocReferenceLabel
hi def link pandocWikiLinkBracket pandocOperator
hi def link pandocWikiLinkTarget pandocReferenceURL
hi def link pandocSimpleCiteBracket pandocOperator
hi def link pandocCiteTail pandocCiteKey
