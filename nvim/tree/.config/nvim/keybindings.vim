"""
""" NAVIGATION
"""

""" change tabs
"   focus tab left
nnoremap H gT
"   focus tab right
nnoremap L gt

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

map <leader>y :TagbarToggle<cr>

"""
""" MISC
"""

""" thesaurus_query.vim
let g:tq_map_keys = 0
nnoremap <leader>t :ThesaurusQueryReplaceCurrentWord<CR>

""" goyo toggle
nnoremap <leader>G :Goyo<cr>
