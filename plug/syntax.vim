""" LANGUAGE PLUGINS

""" graphql
Plug 'jparise/vim-graphql'

""" i3 config
Plug 'mboughaba/i3config.vim'
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

""" pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#modules#disabled = ['folding']
let g:pandoc#filetypes#pandoc_markdown = 0

""" csv
Plug 'mechatroner/rainbow_csv'
