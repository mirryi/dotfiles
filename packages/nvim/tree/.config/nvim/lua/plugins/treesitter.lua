return {
    -- {
    --     -- treesitter support
    --     'nvim-treesitter/nvim-treesitter',
    --     lazy = false,
    --     build = ':TSUpdate',
    --     dependencies = {
    --         'windwp/nvim-ts-autotag',
    --         'nvim-treesitter/nvim-treesitter-context',
    --         'haringsrob/nvim_context_vt',
    --         -- 'hiphish/rainbow-delimiters.nvim',
    --     },
    -- },
    {
        'romus204/tree-sitter-manager.nvim',
        config = function()
            require('tree-sitter-manager').setup {}
        end,
    },
}
