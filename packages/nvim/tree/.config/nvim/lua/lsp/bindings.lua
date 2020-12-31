local U = require('util')
local nmap = U.nmap

-- Goto implementation
nmap('gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent = true})

-- Show signature help
nmap('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {silent = true})

-- Goto type definition
nmap('gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {silent = true})

-- Document symbol help
nmap('g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', {silent = true})

-- Workspace symbol help
nmap('gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {silent = true})

-- Select code action
nmap('gC', '<cmd>lua vim.lsp.buf.code_action()<CR>', {silent = true})

-- Goto next/previous diagnostic
nmap('gN', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {silent = true})
nmap('gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {silent = true})
