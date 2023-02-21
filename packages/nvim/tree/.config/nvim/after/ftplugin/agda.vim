" ## Comments

let &l:comments = 's1fl:{-,mb:-,ex:-},:--'
let &l:commentstring = '-- %s'

" ## Indentation

let &l:indentexpr = 'agda#indent(v:lnum)'

" ## Match pairs

let &l:matchpairs
  \ = '(:)'
  \ . ',{:}'
  \ . ',[:]'
  \ . ',<:>'
  \ . ',«:»'
  \ . ',‹:›'
  \ . ',⁅:⁆'
  \ . ',⁽:⁾'
  \ . ',₍:₎'
  \ . ',⌈:⌉'
  \ . ',⌊:⌋'
  \ . ',〈:〉'
  \ . ',⎛:⎞'
  \ . ',⎜:⎟'
  \ . ',⎝:⎠'
  \ . ',⎡:⎤'
  \ . ',⎢:⎥'
  \ . ',⎣:⎦'
  \ . ',⎧:⎫'
  \ . ',⎨:⎬'
  \ . ',⎩:⎭'
  \ . ',⎪:⎪'
  \ . ',⎴:⎵'
  \ . ',❨:❩'
  \ . ',❪:❫'
  \ . ',❬:❭'
  \ . ',❮:❯'
  \ . ',❰:❱'
  \ . ',❲:❳'
  \ . ',❴:❵'
  \ . ',⟅:⟆'
  \ . ',⟦:⟧'
  \ . ',⟨:⟩'
  \ . ',⟪:⟫'
  \ . ',⦃:⦄'
  \ . ',⦅:⦆'
  \ . ',⦇:⦈'
  \ . ',⦉:⦊'
  \ . ',⦋:⦌'
  \ . ',⦍:⦎'
  \ . ',⦏:⦐'
  \ . ',⦑:⦒'
  \ . ',⦓:⦔'
  \ . ',⦕:⦖'
  \ . ',⦗:⦘'
  \ . ',⸠:⸡'
  \ . ',⸢:⸣'
  \ . ',⸤:⸥'
  \ . ',⸦:⸧'
  \ . ',⸨:⸩'
  \ . ',〈:〉'
  \ . ',《:》'
  \ . ',「:」'
  \ . ',『:』'
  \ . ',【:】'
  \ . ',〔:〕'
  \ . ',〖:〗'
  \ . ',〘:〙'
  \ . ',〚:〛'
  \ . ',︗:︘'
  \ . ',︵:︶'
  \ . ',︷:︸'
  \ . ',︹:︺'
  \ . ',︻:︼'
  \ . ',︽:︾'
  \ . ',︿:﹀'
  \ . ',﹁:﹂'
  \ . ',﹃:﹄'
  \ . ',﹇:﹈'
  \ . ',﹙:﹚'
  \ . ',﹛:﹜'
  \ . ',﹝:﹞'
  \ . ',（:）'
  \ . ',＜:＞'
  \ . ',［:］'
  \ . ',｛:｝'
  \ . ',｟:｠'
  \ . ',｢:｣'
  \ . ',⦇:⦈'

" ## Glyphs

" ### List

let s:glyphs = {}

" #### Combining marks

call extend(s:glyphs,
  \ { 'over`': ' ̀'
  \ , "over'": ' ́'
  \ , 'over^': ' ̂'
  \ , 'overv': ' ̌'
  \ , 'over~': ' ̃'
  \ , 'over-': ' ̄'
  \ , 'over_': ' ̅'
  \ , 'over–': ' ̅'
  \ , 'over—': ' ̅'
  \ , 'overcup': ' ̆'
  \ , 'overcap': ' ̑'
  \ , 'over.': ' ̇'
  \ , 'over..': ' ̈'
  \ , 'over"': ' ̈'
  \ , 'over...': ' ⃛'
  \ , 'overright.': ' ͘'
  \ , 'overo': ' ̊'
  \ , 'over``': ' ̏'
  \ , "over''": ' ̋'
  \ , 'overvec': ' ⃑'
  \ , 'vec': ' ⃑'
  \ , 'overlvec': ' ⃐'
  \ , 'lvec': ' ⃐'
  \ , 'overarc': ' ⃕'
  \ , 'overlarc': ' ⃔'
  \ , 'overto': ' ⃗'
  \ , 'overfrom': ' ⃖'
  \ , 'overfromto': ' ⃡'
  \ , 'over*': ' ⃰'
  \ , 'under`': ' ̖'
  \ , "under'": ' ̗'
  \ , 'under,': ' ̗'
  \ , 'under.': ' ̣'
  \ , 'under..': ' ̤'
  \ , 'under"': ' ̤'
  \ , 'undero': ' ̥'
  \ , 'under-': ' ̱'
  \ , 'under_': ' ̲'
  \ , 'under–': ' ̲'
  \ , 'under—': ' ̲'
  \ , 'through~': ' ̴'
  \ , 'through-': ' ̵'
  \ , 'through_': ' ̶'
  \ , 'through–': ' ̶'
  \ , 'through—': ' ̶'
  \ , 'through/': ' ̷'
  \ , 'not': ' ̷'
  \ , 'through?': ' ̸'
  \ , 'Not': ' ̸'
  \ , 'through\|': ' ⃒'
  \ , 'throughshortmid': ' ⃓'
  \ , 'througho': ' ⃘'
  \ })

" #### Symbols

call extend(s:glyphs,
  \ { '{{': '⦃'
  \ , '}}': '⦄'
  \ , '({': '⦇'
  \ , '})': '⦈'
  \ , '`[': '⌜'
  \ , '`]': '⌟'
  \ , ':': '∶'
  \ , '::': '∷'
  \ , ';': '﹔'
  \ , '..': '‥'
  \ , '=?': '≟'
  \ , 'all': '∀'
  \ , 'always': '□'
  \ , 'approx': '≈'
  \ , 'bot': '⊥'
  \ , 'box': '□'
  \ , 'boxdot': '⊡'
  \ , 'box.': '⊡'
  \ , 'boxminus': '⊟'
  \ , 'box-': '⊟'
  \ , 'boxplus': '⊞'
  \ , 'box+': '⊞'
  \ , 'boxtimes': '⊠'
  \ , 'box*': '⊠'
  \ , 'bul': '•'
  \ , 'C': 'ℂ'
  \ , 'cdot': '∙'
  \ , '.': '∙'
  \ , 'cdots': '⋯'
  \ , 'check': '✓'
  \ , 'yes': '✓'
  \ , 'Check': '✔'
  \ , 'Yes': '✔'
  \ , 'cave': '⸨⸩<left>'
  \ , 'circ': '∘'
  \ , 'clock': '↻'
  \ , 'cclock': '↺'
  \ , 'comp': '∘'
  \ , 'contra': '↯'
  \ , 'cursor': '▹◃<left>'
  \ , 'deg': '°'
  \ , 'den': '⟦⟧<left>'
  \ , 'diamond': '◇'
  \ , 'dot': '·'
  \ , 'dots': '…'
  \ , 'down': '↓'
  \ , 'downtri': '▼'
  \ , 'Down': '⇓'
  \ , 'dunion': '⊎'
  \ , 'du': '⊎'
  \ , 'ell': 'ℓ'
  \ , 'em': '—'
  \ , 'empty': '∅'
  \ , 'equiv': '≡'
  \ , 'eq': '≡'
  \ , '.=': '≐'
  \ , 'eventually': '◇'
  \ , 'exists': '∃'
  \ , 'flat': '♭'
  \ , 'fold': '⦇⦈<left>'
  \ , '(\|': '⦇'
  \ , '\|)': '⦈'
  \ , 'forall': '∀'
  \ , 'from': '←'
  \ , '<-': '←'
  \ , 'From': '⇐'
  \ , 'fromto': '↔'
  \ , 'Fromto': '⇔'
  \ , 'ge': '≥'
  \ , 'glub': '⊓'
  \ , 'Gl-': 'ƛ'
  \ , 'iff': '⇔'
  \ , 'implies': '⇒'
  \ , 'impliedby': '⇐'
  \ , 'in': '∈'
  \ , 'infty': '∞'
  \ , 'inf': '∞'
  \ , 'int': '∫'
  \ , 'intersect': '∩'
  \ , 'iso': '≅'
  \ , '~-': '≃'
  \ , 'join': '⋈'
  \ , 'land': '∧'
  \ , 'langle': '⟨'
  \ , 'lbrac': '⟦'
  \ , '[[': '⟦'
  \ , 'ldots': '…'
  \ , 'ldown': '⇃'
  \ , 'leadsto': '⇝'
  \ , '~>': '⇝'
  \ , 'le': '≤'
  \ , '<~': '≲'
  \ , 'lift': '⌊⌋<left>'
  \ , 'floor': '⌊⌋<left>'
  \ , 'llangle': '⟪'
  \ , 'longto': '⟶ '
  \ , '--': '⟶ '
  \ , '–': '⟶ '
  \ , 'lor': '∨'
  \ , 'lower': '⌈⌉<left>'
  \ , 'ceil': '⌈⌉<left>'
  \ , 'lub': '⊔'
  \ , 'lup': '↿'
  \ , 'mapsto': '↦'
  \ , 'map': '↦'
  \ , 'mid': '∣'
  \ , 'models': '⊨'
  \ , 'monus': '∸'
  \ , '\|=': '⊨'
  \ , 'N': 'ℕ'
  \ , 'ne': '≠'
  \ , 'nearrow': '↗'
  \ , 'Nearrow': '⇗'
  \ , 'neg': '¬'
  \ , '/=': '≠'
  \ , '/~': '~̸'
  \ , 'nequiv': '≢'
  \ , 'neq': '≢'
  \ , 'nexist': '∄'
  \ , 'none': '∄'
  \ , 'ni': '∋'
  \ , 'nin': '∉'
  \ , 'niso': '≇'
  \ , 'notin': '∉'
  \ , 'nni': '∌'
  \ , 'nwarrow': '↖'
  \ , 'Nwarrow': '⇖'
  \ , 'oast': '⊛'
  \ , 'odot': '⊙'
  \ , 'o.': '⊙'
  \ , 'of': '∘'
  \ , 'o': '∘'
  \ , 'ominus': '⊖'
  \ , 'o-': '⊖'
  \ , 'o--': '↬'
  \ , 'oplus': '⊕'
  \ , 'o+': '⊕'
  \ , 'oslash': '⊘'
  \ , 'o/': '⊘'
  \ , 'otimes': '⊗'
  \ , 'o*': '⊗'
  \ , 'par': '∂'
  \ , 'pge': '≽'
  \ , 'pgt': '≻'
  \ , 'ple': '≼'
  \ , 'plt': '≺'
  \ , 'p≥': '≽'
  \ , 'p>': '≻'
  \ , 'p≤': '≼'
  \ , 'p<': '≺'
  \ , 'pm': '±'
  \ , 'prec': '≼'
  \ , 'prod': '∏'
  \ , 'proves': '⊢'
  \ , '\|-': '⊢'
  \ , 'provedby': '⊣'
  \ , 'Q': 'ℚ'
  \ , 'qed': '∎'
  \ , 'R': 'ℝ'
  \ , 'rangle': '⟩'
  \ , 'rbrac': '⟧'
  \ , ']]': '⟧'
  \ , 'rdown': '⇂'
  \ , 'righttri': '▸'
  \ , 'rrangle': '⟫'
  \ , 'rr-': '↠'
  \ , 'rup': '↾'
  \ , 'searrow': '↘'
  \ , 'Searrow': '⇘'
  \ , 'sec': '§'
  \ , 'setminus': '∖'
  \ , 'sharp': '♯'
  \ , '#': '♯'
  \ , 'sim': '∼'
  \ , 'simeq': '≃'
  \ , 'some': '∃'
  \ , 'sqge': '⊒'
  \ , 'sqgt': '⊐'
  \ , 'sqle': '⊑'
  \ , 'sqlt': '⊏'
  \ , 's≥': '⊒'
  \ , 's>': '⊐'
  \ , 's≤': '⊑'
  \ , 's<': '⊏'
  \ , 'sqcup': '⊔'
  \ , 'sqr': '²'
  \ , 'sqrt': '√'
  \ , 'star': '✭'
  \ , 'subset': '⊂'
  \ , 'sub': '⊂'
  \ , 'subseteq': '⊆'
  \ , 'subeq': '⊆'
  \ , 'subsetneq': '⊊'
  \ , 'subneq': '⊊'
  \ , 'sum': '∑'
  \ , 'supset': '⊃'
  \ , 'sup': '⊃'
  \ , 'supseteq': '⊇'
  \ , 'supeq': '⊇'
  \ , 'supsetneq': '⊋'
  \ , 'supneq': '⊋'
  \ , 'swarrow': '↙'
  \ , 'Swarrow': '⇙'
  \ , 'thus': '∴'
  \ , 'times': '×'
  \ , '*': '×'
  \ , 'to': '→'
  \ , '-': '→'
  \ , 'To': '⇒'
  \ , '=': '⇒'
  \ , 'top': '⊤'
  \ , 'tuple': '⟨⟩<left>'
  \ , 'up': '↑'
  \ , 'updown': '↕'
  \ , 'ud': '↕'
  \ , 'unfold': '⦉⦊<left>'
  \ , '<\|': '⦉'
  \ , '\|>': '⦊'
  \ , 'up;down': '⇅'
  \ , 'u;d': '⇅'
  \ , 'u+': '⊎'
  \ , 'uptri': '▲'
  \ , 'Up': '⇑'
  \ , 'union': '∪'
  \ , 'vdash': '⊢'
  \ , 'vdots': '⋮'
  \ , 'voltage': '⚡'
  \ , 'x': '×'
  \ , 'xmark': '✗'
  \ , 'no': '✗'
  \ , 'Xmark': '✘'
  \ , 'No': '✘'
  \ , 'Z': 'ℤ'
  \ , '<': '⟨'
  \ , '>': '⟩'
  \ , ':::': '⦂'
  \ })

" #### Superscripts

call extend(s:glyphs,
  \ { '^0': '⁰'
  \ , '^1': '¹'
  \ , '^2': '²'
  \ , '^3': '³'
  \ , '^4': '⁴'
  \ , '^5': '⁵'
  \ , '^6': '⁶'
  \ , '^7': '⁷'
  \ , '^8': '⁸'
  \ , '^9': '⁹'
  \ , '^n': 'ⁿ'
  \ , '^i': 'ⁱ'
  \ , '^+': '⁺'
  \ , '^-': '⁻'
  \ , '^b': 'ᵇ'
  \ , '^c': 'ᶜ'
  \ , '^l': 'ˡ'
  \ , '^r': 'ʳ'
  \ , "'": '′'
  \ , "''": '″'
  \ , "'''": '‴'
  \ , "''''": '⁗'
  \ , '"': '″'
  \ , '""': '⁗'
  \ , '`': '‵'
  \ , '``': '‶'
  \ , '```': '‷'
  \ })

" #### Subscripts

call extend(s:glyphs,
  \ { '0': '₀'
  \ , '1': '₁'
  \ , '2': '₂'
  \ , '3': '₃'
  \ , '4': '₄'
  \ , '5': '₅'
  \ , '6': '₆'
  \ , '7': '₇'
  \ , '8': '₈'
  \ , '9': '₉'
  \ , '_i': 'ᵢ'
  \ , '_j': 'ⱼ'
  \ , '_+': '₊'
  \ , '_-': '₋'
  \ , 'p0': 'π₀'
  \ , 'p1': 'π₁'
  \ , 'p2': 'π₂'
  \ , 'p3': 'π₃'
  \ , 'p4': 'π₄'
  \ , 'p5': 'π₅'
  \ , 'p6': 'π₆'
  \ , 'p7': 'π₇'
  \ , 'p8': 'π₈'
  \ , 'p9': 'π₉'
  \ , 'i0': 'ι₀'
  \ , 'i1': 'ι₁'
  \ , 'i2': 'ι₂'
  \ , 'i3': 'ι₃'
  \ , 'i4': 'ι₄'
  \ , 'i5': 'ι₅'
  \ , 'i6': 'ι₆'
  \ , 'i7': 'ι₇'
  \ , 'i8': 'ι₈'
  \ , 'i9': 'ι₉'
  \ })

" #### Greek

" ##### Lowercase

call extend(s:glyphs,
  \ { 'alpha': 'α'
  \ , 'a': 'α'
  \ , 'beta': 'β'
  \ , 'b': 'β'
  \ , 'gamma': 'γ'
  \ , 'g': 'γ'
  \ , 'delta': 'δ'
  \ , 'd': 'δ'
  \ , 'epsilon': 'ε'
  \ , 'e': 'ε'
  \ , 'zeta': 'ζ'
  \ , 'z': 'ζ'
  \ , 'eta': 'η'
  \ , 'h': 'η'
  \ , 'theta': 'θ'
  \ , 'iota': 'ι'
  \ , 'i': 'ι'
  \ , 'kappa': 'κ'
  \ , 'k': 'κ'
  \ , 'lambda': 'λ'
  \ , 'l': 'λ'
  \ , 'mu': 'μ'
  \ , 'm': 'μ'
  \ , 'nu': 'ν'
  \ , 'n': 'ν'
  \ , 'xi': 'ξ'
  \ , 'omicron': 'ο'
  \ , 'pi': 'π'
  \ , 'p': 'π'
  \ , 'rho': 'ρ'
  \ , 'r': 'ρ'
  \ , 'sigma': 'σ'
  \ , 's': 'σ'
  \ , 'varsigma': 'ς'
  \ , 'vars': 'ς'
  \ , 'tau': 'τ'
  \ , 't': 'τ'
  \ , 'u': 'υ'
  \ , 'phi': 'φ'
  \ , 'f': 'φ'
  \ , 'chi': 'χ'
  \ , 'psi': 'ψ'
  \ , 'c': 'ψ'
  \ , 'omega': 'ω'
  \ , 'v': 'ω'
  \ })

" ##### Uppercase

call extend(s:glyphs,
  \ { 'Alpha': 'Α'
  \ , 'Beta': 'Β'
  \ , 'Gamma': 'Γ'
  \ , 'G': 'Γ'
  \ , 'Delta': 'Δ'
  \ , 'D': 'Δ'
  \ , 'Epsilon': 'Ε'
  \ , 'Zeta': 'Ζ'
  \ , 'Eta': 'Η'
  \ , 'Theta': 'Θ'
  \ , 'Iota': 'Ι'
  \ , 'Kappa': 'Κ'
  \ , 'Lambda': 'Λ'
  \ , 'L': 'Λ'
  \ , 'Mu': 'Μ'
  \ , 'Nu': 'Ν'
  \ , 'Xi': 'Ξ'
  \ , 'Omicron': 'Ο'
  \ , 'Pi': 'Π'
  \ , 'P': 'Π'
  \ , 'Rho': 'Ρ'
  \ , 'Sigma': 'Σ'
  \ , 'S': 'Σ'
  \ , 'Tau': 'Τ'
  \ , 'Upsilon': 'Υ'
  \ , 'Phi': 'Φ'
  \ , 'F': 'Φ'
  \ , 'Chi': 'Χ'
  \ , 'Psi': 'Ψ'
  \ , 'Omega': 'Ω'
  \ , 'V': 'Ω'
  \ })

" ### Bindings

for [s:sequence, s:symbol] in items(s:glyphs)
  execute 'noremap! <buffer> <LocalLeader>' . s:sequence . ' ' . s:symbol
endfor
