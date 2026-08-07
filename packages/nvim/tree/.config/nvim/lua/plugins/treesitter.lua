return {
    {
        'romus204/tree-sitter-manager.nvim',
        config = function()
            -- markdown/pandoc is highlighted by vim-pandoc-syntax
            require('tree-sitter-manager').setup { nohighlight = { 'markdown' } }
        end,
    },
}
