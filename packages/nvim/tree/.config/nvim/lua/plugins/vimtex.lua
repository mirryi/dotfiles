-- luacheck: globals vim
local g = vim.g

g.vimtex_enabled = 1

-- Syntax options
g.vimtex_syntax_enabled = 1
g.vimtex_syntax_custom_cmds = {
    {name = 'vert', mathmode = 1, conceal = 1, concealchar = '|'},
    {name = 'textbf', mathmode = 1, conceal = 1, argstyle = 'bold'}
}

-- View options
g.vimtex_view_method = 'zathura'
