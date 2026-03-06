vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.name == 'rust_analyzer' then
            vim.keymap.set('n', 'gra', function()
                vim.cmd.RustLsp('codeAction')
            end, { buffer = ev.buf })
            vim.keymap.set('n', 'gE', function()
                vim.cmd.RustLsp('renderDiagnostic')
            end, { buffer = ev.buf })
            vim.keymap.set('n', 'K', function()
                vim.cmd.RustLsp { 'hover', 'actions' }
            end, { buffer = ev.buf })
            vim.keymap.set('n', 'gj', function()
                vim.cmd.RustLsp('joinLines')
            end, { buffer = ev.buf })
        end
    end,
})
