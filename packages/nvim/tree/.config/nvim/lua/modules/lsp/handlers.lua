-- luacheck: globals vim
local M = {}

-- Diagnostics handler
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
})

-- Grouped on_attach
M.on_attach = function(client, bufnr)
    -- Jump to diagnostics
    vim.keymap.set('n', 'gN', function()
        vim.diagnostic.goto_prev()
    end, { desc = 'Jump to previous diagnostic' }, true)
    vim.keymap.set('n', 'gn', function()
        vim.diagnostic.goto_next()
    end, { desc = 'Jump to next diagnostic' }, true)

    -- Goto definition
    if client.server_capabilities.definitionProvider then
        vim.keymap.set('n', 'gd', function()
            vim.lsp.buf.definition()
        end, { desc = 'Jump to definition' }, true)
        vim.keymap.set('n', 'gH', function()
            require('modules.lsp.helpers').peek_definition()
        end, { desc = 'Peek definition' }, true)
    end
    -- Goto declaration
    if client.server_capabilities.declarationProvider then
        vim.keymap.set('n', 'gD', function()
            vim.lsp.buf.declaration()
        end, { desc = 'Jump to declaration' }, true)
    end
    -- Goto implementation
    if client.server_capabilities.implementationProvider then
        vim.keymap.set('n', 'gi', function()
            vim.lsp.buf.implementation()
        end, { desc = 'Jump to implementation' }, true)
    end
    -- Goto type definition
    if client.server_capabilities.typeDefinitionProvider then
        vim.keymap.set('n', 'gy', function()
            vim.lsp.buf.type_definition()
        end, { desc = 'Jump to type definition' }, true)
    end
    -- Show hover information
    if client.server_capabilities.hoverProvider then
        vim.keymap.set('n', 'gh', function()
            vim.lsp.buf.hover()
        end, { desc = 'Show hover information' }, true)
    end
    -- Show signature help
    if client.server_capabilities.signatureHelpProvider then
        vim.keymap.set('n', 'gs', function()
            vim.lsp.buf.signature_help()
        end, { desc = 'Show signature help' }, true)
    end
    -- List references
    if client.server_capabilities.referencesProvider then
        vim.keymap.set('n', 'gr', function()
            vim.lsp.buf.references()
        end, { desc = 'List references to symbol' }, true)
        -- vim.keymap.set('n', 'gr', '<cmd>LSPReferences<CR>')
    end
    -- Rename the hovered symbol
    if client.server_capabilities.renameProvider then
        vim.keymap.set('n', 'gR', function()
            vim.lsp.buf.rename()
        end, { desc = 'Rename symbol' }, true)
    end
    -- Select a code action
    if client.server_capabilities.codeActionProvider then
        vim.keymap.set('n', 'gC', function()
            vim.lsp.buf.code_action()
        end, { desc = 'Code action' }, true)
    end

    -- Show diagnostics for the current line
    vim.keymap.set('n', 'gE', function()
        vim.diagnostic.open_float { focus = false }
    end, { desc = 'Open diagnostic' }, true)

    -- If server supports formatting, format on save.
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_command([[augroup Format]])
        vim.api.nvim_command(
            [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.format { filter = function(client) return client.name ~= "ts_ls" end }]]
        )
        vim.api.nvim_command([[augroup END]])
    end

    -- If range formatting is supported, add a keybind
    if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('v', '<leader>f', function()
            vim.lsp.buf.range_formatting()
        end, { desc = 'Format range' }, true)
    end

    -- Attach virtual types indicator.
    if client.server_capabilities.codeLensProvider then
        local virtualtypes = require('virtualtypes')
        virtualtypes.on_attach(client, bufnr)
    end

    -- Disable semantic highlighting
    client.server_capabilities.semanticTokensProvider = nil
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
