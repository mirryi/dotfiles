-- luacheck: globals vim
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo

--
-- Editor Defaults
--

-- Enable syntax and indent
vim.cmd([[syntax on]])
vim.cmd([[filetype plugin indent on]])

-- Map leader
g.mapleader = '\\'

-- Keep buffers around
o.hidden = true
-- Avoid hit-enter messages
o.shortmess = o.shortmess .. 'c'
-- Updatetime for CursorHold
o.updatetime = 100
-- Always 10 lines below cursor
o.scrolloff = 10

-- Transparent popupmenu
o.pumblend = 15

-- Ignore case in search
o.ignorecase = true
-- Unless search with uppercase
o.smartcase = true

-- Show signcolumns
wo.signcolumn = 'yes'
-- Show line numbers
wo.number = true
wo.relativenumber = true
-- Show cursorline
wo.cursorline = true
-- No softwrap
wo.wrap = false

-- Folds
wo.foldcolumn = '1'
wo.foldenable = true
wo.foldlevel = 99

-- Tabs (space tabs)
o.smarttab = true
o.expandtab = true
o.autoindent = true
o.cindent = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2

-- Completion
o.completeopt = 'menuone,noinsert,noselect'

-- Undo
bo.undofile = true
vim.cmd([[let &undodir=stdpath('cache') . '/undo']], true)

-- No local .vimrc files
o.exrc = false
o.secure = true

-- Enable termguicolors
-- Sequences for RGB colors
o.termguicolors = true
vim.cmd([[
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
]])
