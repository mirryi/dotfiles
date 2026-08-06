return {
    {
        -- highlight ranges
        'winston0410/range-highlight.nvim',
        dependencies = { 'winston0410/cmd-parser.nvim' },
        event = { 'CmdlineEnter' },
        opts = {},
    },
    {
        -- preview search and replace
        'markonm/traces.vim',
    },
    {
        -- unix commands
        'tpope/vim-eunuch',
        init = function()
            -- close orphaned buffer after :Remove
            vim.api.nvim_create_autocmd('User', {
                pattern = 'FileUnlinkPost',
                callback = function()
                    if #vim.fn.getbufinfo { buflisted = 1 } > 1 then
                        vim.cmd('bdelete!')
                    end
                end,
            })
        end,
    },
}
