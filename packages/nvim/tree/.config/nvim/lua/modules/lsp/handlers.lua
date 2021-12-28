-- luacheck: globals vim
local U = require('util')

local M = {}

-- Diagnostics handler
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = true,
	signs = true,
	update_in_insert = false,
})

-- Use lsputil handlers
-- vim.lsp.handlers['textDocument/codeAction'] = require('lsputil.locations').code_action_handler
vim.lsp.handlers['textDocument/references'] = require('lsputil.locations').references_handler
vim.lsp.handlers['textDocument/definition'] = require('lsputil.locations').definition_handler
vim.lsp.handlers['textDocument/declaration'] = require('lsputil.locations').declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require('lsputil.locations').typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require('lsputil.locations').implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require('lsputil.symbols').document_handler
vim.lsp.handlers['workspace/symbol'] = require('lsputil.symbols').workspace_handler
vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
	local util = vim.lsp.util
	config = config or {}
	config.focus_id = ctx.method
	if not (result and result.contents) then
		return { 'No information available' }
	end
	local markdown_lines = util.convert_input_to_markdown_lines(result.contents)
	markdown_lines = util.trim_empty_lines(markdown_lines)
	if vim.tbl_isempty(markdown_lines) then
		return { 'No information available' }
	end
	return util.open_floating_preview(markdown_lines, 'pandoc', config)
end

-- Async formatting handle
-- TODO: no global
vim.g.format = true
vim.cmd([[command! FormatOn :lua vim.g.format = true ]])
vim.cmd([[command! FormatOff :lua vim.g.format = false ]])
vim.cmd([[command! FormatToggle :lua vim.g.format = not vim.g.format ]])

vim.lsp.handlers['textDocument/formatting'] = function(err, result, ctx, _)
	if not vim.g.format then
		return
	end
	if err ~= nil or result == nil then
		return
	end

	local bufnr = ctx.bufnr
	if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
		local view = vim.fn.winsaveview()
		vim.lsp.util.apply_text_edits(result, bufnr)
		vim.fn.winrestview(view)
		if bufnr == vim.api.nvim_get_current_buf() then
			vim.api.nvim_command('noautocmd :update')
		end
	end
end

-- Grouped on_attach
M.on_attach = function(client, bufnr)
	local buf_opt = function(name, value)
		U.buf_opt(bufnr, name, value)
	end

	-- Bind lsp functionality for this buffer
	local bufmap = function(mode, lhs, rhs)
		U.bind.buf.map(bufnr, mode, lhs, rhs, { noremap = false })
	end

	-- Set omnifunc
	-- buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Goto definition
	bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
	-- bufmap('n', 'gd', '<cmd>LSPGotoDefinition<CR>')
	-- Goto declaration
	bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
	-- Goto implementation
	bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
	-- Goto type definition
	bufmap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
	-- Show hover information
	bufmap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>')
	-- Show signature help
	bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
	-- List references
	bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
	-- bufmap('n', 'gr', '<cmd>LSPReferences<CR>')
	-- Rename the hovered symbol
	bufmap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>')
	-- Select a code action
	-- bufmap('n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	bufmap('n', 'gc', '<cmd>LSPActions<CR>')
	-- bufmap('n', 'gc', '<cmd>CodeActionMenu<CR>')
	-- Show diagnostics for the current line
	bufmap('n', 'ge', '<cmd>lua vim.diagnostic.open_float({focus = false})<CR>')
	-- Show document diagnostics list
	bufmap('n', 'gQ', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
	-- bufmap('n', 'gQ', '<cmd>LSPDiagnostics<CR>')
	-- Show workspace diagnostics list
	-- bufmap('n', 'gwQ', '<cmd>LSPWDiagnostics<CR>')
	-- Workspace functionality
	bufmap('n', 'gwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
	bufmap('n', 'gwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
	bufmap('n', 'gwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

	-- If server supports formatting, format on save.
	-- TODO: Toggle for formatting
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_command([[augroup Format]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
		vim.api.nvim_command([[augroup END]])
	end

	-- If range formatting is supported, add a keybind
	if client.resolved_capabilities.document_range_formatting then
		bufmap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
	end

	-- Attach signature help
	local signature = require('lsp_signature')
	signature.on_attach()

	-- Attach word highlighting
	-- local illuminate = require('illuminate')
	-- illuminate.on_attach(client, bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enable snippets
M.capabilities.offsetEncoding = {'utf-16'}
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

return M
