return {
    {
        -- git signs in the signcolumn
        'lewis6991/gitsigns.nvim',
        config = function()
            local gitsigns = require('gitsigns')
            gitsigns.setup()
        end,
    },
    {
        -- lazygit
        'kdheepak/lazygit.nvim',
        config = function()
            vim.keymap.set('n', '<leader>gl', '<cmd>LazyGit<CR>')
        end,
    },
}
