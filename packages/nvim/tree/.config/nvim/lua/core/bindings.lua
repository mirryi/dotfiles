-- luacheck: globals vim

-- Fix previous spelling error
vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', { noremap = true })
