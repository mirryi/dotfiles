-- luacheck: globals vim
local bind = require('util.bind')

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
    local bufnr, winnr = util.open_floating_preview(markdown_lines, 'pandoc', config)
    vim.api.nvim_buf_set_option(bufnr, 'filetype', 'pandoc')
    return bufnr, winnr
end

vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    local notify = require('notify')

    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({
        'ERROR',
        'WARN',
        'INFO',
        'DEBUG',
    })[result.type]
    notify({ result.message }, lvl, {
        title = 'LSP | ' .. client.name,
        timeout = 10000,
        keep = function()
            return lvl == 'ERROR' or lvl == 'WARN'
        end,
    })
end

-- Grouped on_attach
M.on_attach = function(client, bufnr)
    -- Bind lsp functionality for this buffer
    local bufmap = function(mode, lhs, rhs, desc)
        bind.buf.map(bufnr, mode, lhs, rhs, { noremap = false, desc = desc })
    end

    -- Jump to diagnostics
    bufmap('n', 'gN', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    bufmap('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')

    -- Goto definition
    if client.server_capabilities.definitionProvider then
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
        -- bufmap('n', 'gd', '<cmd>LspGotoDefinition<CR>')
        bufmap('n', 'gH', '<cmd>lua require("modules.lsp.helpers").peek_definition()<CR>')
    end
    -- Goto declaration
    if client.server_capabilities.declarationProvider then
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    end
    -- Goto implementation
    if client.server_capabilities.implementationProvider then
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    end
    -- Goto type definition
    if client.server_capabilities.typeDefinitionProvider then
        bufmap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    end
    -- Show hover information
    if client.server_capabilities.hoverProvider then
        bufmap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>')
    end
    -- Show signature help
    if client.server_capabilities.signatureHelpProvider then
        bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    end
    -- List references
    if client.server_capabilities.referencesProvider then
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
        -- bufmap('n', 'gr', '<cmd>LSPReferences<CR>')
    end
    -- Rename the hovered symbol
    if client.server_capabilities.renameProvider then
        bufmap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>')
    end
    -- Select a code action
    if client.server_capabilities.codeActionProvider then
        bufmap('n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    end

    -- Show diagnostics for the current line
    bufmap('n', 'ge', '<cmd>lua vim.diagnostic.open_float({focus = false})<CR>')

    -- Show document diagnostics list
    bufmap('n', 'gQ', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')

    -- Workspace functionality
    -- bufmap('n', 'gwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    -- bufmap('n', 'gwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    -- bufmap('n', 'gwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

    -- If server supports formatting, format on save.
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_command([[augroup Format]])
        vim.api.nvim_command([[autocmd! BufWritePost <buffer> lua vim.lsp.buf.format()]])
        vim.api.nvim_command([[augroup END]])
    end

    -- If range formatting is supported, add a keybind
    if client.server_capabilities.documentRangeFormattingProvider then
        bufmap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
    end

    -- Attach signature help
    if client.server_capabilities.signatureHelpProvider then
        local signature = require('lsp_signature')
        signature.on_attach()
    end

    -- Attach virtual types indicator.
    if client.server_capabilities.codeLensProvider then
        local virtualtypes = require('virtualtypes')
        virtualtypes.on_attach(client, bufnr)
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enable range folding
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

-- Enable snippets
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

return M
