-- luacheck: globals vim
local metals = require('metals')

local handlers = require('modules.lsp.handlers')

local config = metals.bare_config
config.on_attach = handlers.on_attach
config.capabilities = handlers.capabilities
metals.initialize_or_attach(config)

vim.api.nvim_command([[augroup NvimMetals]])
vim.api.nvim_command([[autocmd!]])
vim.api.nvim_command([[autocmd BufEnter <buffer> lua require'metals'.did_focus()]])
vim.api.nvim_command([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
-- vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
vim.api.nvim_command([[augroup end]])
