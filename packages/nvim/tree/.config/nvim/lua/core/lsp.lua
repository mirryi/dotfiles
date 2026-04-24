-- configure diagnostics
vim.diagnostic.config {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
}

-- show diagnostics on hover
vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        vim.diagnostic.open_float { focus = false }
    end,
})

local lsp_format_group = vim.api.nvim_create_augroup('LspFormat', { clear = true })

-- configure lsp keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local opts = { buffer = ev.buf }

        -- goto diagnostics
        vim.keymap.set('n', 'gn', function()
            vim.diagnostic.goto_next()
        end, vim.tbl_extend('force', opts, { desc = 'Jump to next diagnostic' }))
        vim.keymap.set('n', 'gN', function()
            vim.diagnostic.goto_prev()
        end, vim.tbl_extend('force', opts, { desc = 'Jump to previous diagnostic' }))

        -- goto declaration
        if client:supports_method('textDocument/declaration') then
            vim.keymap.set('n', 'gD', function()
                vim.lsp.buf.declaration()
            end, vim.tbl_extend('force', opts, { desc = 'Jump to declaration' }))
        end

        -- goto type definition
        if client:supports_method('textDocument/typeDefinition') then
            vim.keymap.set('n', 'gy', function()
                vim.lsp.buf.type_definition()
            end, vim.tbl_extend('force', opts, { desc = 'Jump to type definition' }))
        end

        -- if server supports formatting, format on save.
        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = lsp_format_group,
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end

        -- range formatting
        if client:supports_method('textDocument/rangeFormatting') then
            vim.keymap.set('v', '<leader>f', function()
                vim.lsp.buf.format()
            end, vim.tbl_extend('force', opts, { desc = 'Format range' }))
        end

        -- disable semantic highlighting
        client.server_capabilities.semanticTokensProvider = nil
    end,
})
