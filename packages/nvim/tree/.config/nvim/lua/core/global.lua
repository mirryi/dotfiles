local g, o, wo = vim.g, vim.o, vim.wo

-- map leader
g.mapleader = '\\'

-- keep buffers around
o.hidden = true
-- avoid hit-enter messages
o.shortmess = o.shortmess .. 'c'
-- updatetime for CursorHold
o.updatetime = 100
-- always 10 lines below cursor
o.scrolloff = 10

-- transparent popupmenu
o.pumblend = 15

-- ignore case in search
o.ignorecase = true
-- unless search with uppercase
o.smartcase = true

-- show signcolumns
wo.signcolumn = 'yes'
-- show line numbers
wo.number = true
wo.relativenumber = true
-- show cursorline
wo.cursorline = true
-- no softwrap
wo.wrap = false

-- folds
wo.foldcolumn = '1'
wo.foldenable = true
wo.foldlevel = 99

-- indentation
o.smarttab = true
o.expandtab = true
o.autoindent = true
o.cindent = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2

-- completion
o.completeopt = 'menuone,noinsert,noselect'

-- undo
o.undofile = true
o.undodir = vim.fn.stdpath('cache') .. '/undo'

-- no local .vimrc files
o.exrc = false
o.secure = true

-- disable netrw
g.loaded_netrwPlugin = 1

-- colors
o.termguicolors = true
