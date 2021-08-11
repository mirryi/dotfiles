-- luacheck: globals vim
local cmd, fn = vim.cmd, vim.fn

fn['wilder#enable_cmdline_enter']()
cmd [[set wildcharm=<Tab>]]

cmd [[cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"]]
cmd [[cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"]]

fn['wilder#set_option']('modes', {'/', '?', ':'})

vim.api.nvim_exec([[
call wilder#set_option('renderer', wilder#popupmenu_renderer({'highlighter': wilder#basic_highlighter(), 'left': [wilder#popupmenu_devicons()]}))
call wilder#set_option('pipeline', [wilder#branch([ wilder#check({_, x -> empty(x)}), wilder#history(), ], wilder#cmdline_pipeline(), wilder#search_pipeline())])
]], false)
