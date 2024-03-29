-- luacheck: globals vim
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo

-- Python paths
g.python_host_prog = '/usr/bin/python2'
g.python3_host_prog = '/usr/bin/python3'

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
local function opt(name, value)
    o[name] = value
    bo[name] = value
end

o.smarttab = true
opt('expandtab', true)
opt('autoindent', true)
opt('cindent', true)
opt('tabstop', 2)
opt('shiftwidth', 2)
opt('softtabstop', 2)

-- Completion
o.completeopt = 'menuone,noinsert,noselect'

-- Undo
bo.undofile = true
vim.api.nvim_exec([[let &undodir=stdpath('cache') . '/undo']], true)

-- No local .vimrc files
o.exrc = false
o.secure = true

-- Enable termguicolors
-- Sequences for RGB colors
o.termguicolors = true
vim.api.nvim_command([[
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
]])
