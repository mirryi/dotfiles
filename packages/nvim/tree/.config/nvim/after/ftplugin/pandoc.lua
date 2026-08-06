local bo = vim.bo

-- tab size
bo.tabstop = 4
bo.shiftwidth = 4
bo.expandtab = true

-- zk mappings
if require('zk.util').notebook_root(vim.fn.expand('%:p')) ~= nil then
    local function map(...)
        vim.api.nvim_buf_set_keymap(0, ...)
    end
    local opts = { noremap = true, silent = false }

    -- create a new note after asking for its title.
    map('n', '<leader>zn', "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
    -- create a new note in the same directory as the current buffer, using the current selection for title
    map('v', '<leader>znt', ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
    -- create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title
    map(
        'v',
        '<leader>znc',
        ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
        opts
    )

    -- open notes linked by the current buffer
    map('n', '<leader>zl', '<Cmd>ZkLinks<CR>', opts)
    -- open notes linking to the current buffer
    map('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', opts)
    --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
end
