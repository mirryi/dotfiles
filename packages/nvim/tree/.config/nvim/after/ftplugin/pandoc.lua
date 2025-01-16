-- luacheck: globals vim
local bo, wo = vim.bo, vim.wo

-- textwidth
bo.textwidth = 100

-- tab size
bo.tabstop = 4
bo.shiftwidth = 4
bo.expandtab = true

-- no wrapping
wo.wrap = false

vim.cmd [[LongLines]]
