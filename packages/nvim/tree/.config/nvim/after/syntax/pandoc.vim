syn region pandocWikiLink matchgroup=pandocOperator start=/\[\[/ end=/\]\]/ concealends oneline keepend display contains=pandocWikiLinkTarget containedin=ALLBUT,pandocCodeblock,pandocCodePre,pandocCodeBlockInsideIndent,pandocDelimitedCodeBlock,pandocNoFormatted,pandocYAMLHeader,pandocWikiLink
syn match pandocWikiLinkTarget /\%(\[\[\)\@2<=[^][|]*|/ contained conceal

syn region pandocSimpleCite matchgroup=pandocOperator start=/\[\%(-\=@[[:alnum:]_][[:alnum:]_:.#$%&+?<>~-]*\]\)\@=/ end=/\]/ concealends oneline keepend display contains=pandocCiteKey containedin=ALLBUT,pandocCodeblock,pandocCodePre,pandocCodeBlockInsideIndent,pandocDelimitedCodeBlock,pandocNoFormatted,pandocYAMLHeader,pandocWikiLink,pandocSimpleCite
syn match pandocCiteTail /[[:alnum:]_]\@1<=[[:upper:][:digit:]][[:alnum:]_:.#$%&+?<>~-]*/ contained containedin=pandocCiteKey conceal display

hi def link pandocWikiLink pandocReferenceLabel
hi def link pandocWikiLinkTarget pandocReferenceURL
hi def link pandocCiteTail pandocCiteKey
