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
    },
}
