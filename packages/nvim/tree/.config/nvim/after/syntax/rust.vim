scriptencoding utf-8

" `relation` is only a keyword inside a `zenith!(...)` invocation (any of
" `()`/`{}`/`[]`, arbitrary whitespace, and an optional `path::` prefix).
" NB: `contains=TOP,{group}` *excludes* {group} from TOP (see :syn-priority),
" and that exclusion applies inside `:syn cluster` too, so there is no way to
" say "TOP plus these contained groups" via `contains=`. Use `containedin=`
" instead: it injects our contained groups into the target regions' contains
" list from the outside, so those regions can keep plain `contains=TOP` (true
" unmodified TOP) and still get normal Rust highlighting inside them.
let s:zenithContainers = 'rustZenithMacroCall,rustZenithNestParens,rustZenithNestBrack,rustZenithNestCurly'
exe 'syn keyword rustZenithKeyword relation contained containedin=' . s:zenithContainers

" matchgroup keeps the delimiter chars themselves out of `contains` scanning
" (:syn-contains: "contained groups will also match in the start and end
" patterns"); without it, vendored items like rustFoldBraces also match the
" same `{`, nest on top, and steal the `}` that should have closed this one.
exe 'syn region rustZenithNestParens matchgroup=rustMacro start="(" end=")" transparent contained containedin=' . s:zenithContainers
exe 'syn region rustZenithNestBrack  matchgroup=rustMacro start="\[" end="\]" transparent contained containedin=' . s:zenithContainers
exe 'syn region rustZenithNestCurly  matchgroup=rustMacro start="{" end="}" transparent contained containedin=' . s:zenithContainers
unlet s:zenithContainers

let s:zenithStart = '\%(\w\+::\)*\<zenith!\_s*'
exe 'syn region rustZenithMacroCall matchgroup=rustMacro start="' . s:zenithStart . '("  end=")"  contains=TOP'
exe 'syn region rustZenithMacroCall matchgroup=rustMacro start="' . s:zenithStart . '{"  end="}"  contains=TOP'
exe 'syn region rustZenithMacroCall matchgroup=rustMacro start="' . s:zenithStart . '\["  end="\]"  contains=TOP'
unlet s:zenithStart

hi def link rustZenithKeyword rustKeyword

if !get(g:, 'rust_conceal', 0) || !has('conceal') || &encoding !=# 'utf-8'
    finish
endif

" For those who don't want to see `::`...
if get(g:, 'rust_conceal_mod_path', 0)
    syn match rustNiceOperator "::" conceal cchar=ㆍ
endif

syn match rustRightArrowHead contained ">" conceal cchar= 
syn match rustRightArrowTail contained "-" conceal cchar=⟶
syn match rustNiceOperator "->" contains=rustRightArrowHead,rustRightArrowTail

syn match rustFatRightArrowHead contained ">" conceal cchar= 
syn match rustFatRightArrowTail contained "=" conceal cchar=⟹
syn match rustNiceOperator "=>" contains=rustFatRightArrowHead,rustFatRightArrowTail

syn match rustNiceOperator /\<\@!_\(_*\>\)\@=/ conceal cchar=′

" For those who don't want to see `pub`...
if get(g:, 'rust_conceal_pub', 0)
    syn match rustPublicSigil contained "pu" conceal cchar=＊
    syn match rustPublicRest contained "b" conceal cchar= 
    syn match rustNiceOperator "pub " contains=rustPublicSigil,rustPublicRest
endif

hi link rustNiceOperator Operator

if !get(g:, 'rust_conceal_mod_path', 0)
    hi! link Conceal Operator

    augroup rust.vim.after
        autocmd!
        " And keep it after a colorscheme change
        autocmd ColorScheme <buffer> hi! link Conceal Operator
    augroup END
endif

" vim: set et sw=4 sts=4 ts=8:
