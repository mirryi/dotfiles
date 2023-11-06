if version < 600
  syntax clear
elseif exists("b:current_syntax") && b:current_syntax != "dafny"
  finish
endif

" reset syntax highlighting for the current buffer.
syntax clear
" dafny is case sensitive.
syntax case match

syntax keyword dafnyFunction function predicate copredicate
syntax keyword dafnyMethod method lemma constructor colemma 
syntax keyword dafnyTypeDef class datatype codatatype newtype type iterator trait extends
syntax keyword dafnyModule abstract module import opened as default
syntax keyword dafnyConditional if then else match case
syntax keyword dafnyRepeat while
syntax keyword dafnyStatement assume assert return yield new print break label where calc modify
syntax keyword dafnyKeyword var ghost returns yields null static protected this refines include inductive exclusively const
syntax keyword dafnyType bool char nat int real set multiset seq string map imap object array array2 array3
syntax keyword dafnyLogic requires ensures modifies reads decreases invariant
syntax keyword dafnyOperator forall exists old fresh
syntax keyword dafnyBoolean true false

syntax region dafnyString start=/"/ skip=/\\"/ end=/"/

syntax match dafnyComment /\/\/.*/
syntax region dafnyComment start="/\*" end="\*/"

syntax match dafnyNumber /\d\+\>/
syntax match dafnyIdentifier /\<\w\+\>/

syntax match dafnyOperator "==>"
syntax match dafnyOperator "<=="
syntax match dafnyOperator "<==>"
syntax match dafnyOperator "|"
syntax match dafnyOperator "::"

highlight link dafnyFunction Statement
highlight link dafnyMethod Statement
highlight link dafnyModule StorageClass
highlight link dafnyTypeDef Typedef
highlight link dafnyConditional Conditional
highlight link dafnyRepeat Repeat
highlight link dafnyKeyword Keyword
highlight link dafnyType Type
highlight link dafnyLogic Debug
highlight link dafnyComment Comment
highlight link dafnyString String
highlight link dafnyNumber Number
highlight link dafnyOperator Operator
highlight link dafnyStatement Statement
highlight link dafnyBoolean Boolean
