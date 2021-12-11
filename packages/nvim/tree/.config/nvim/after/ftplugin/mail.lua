-- luacheck: globals vim
local bo, wo = vim.bo, vim.wo

bo.textwidth = 0

wo.wrap = true
wo.linebreak = true
wo.showbreak = '+'
