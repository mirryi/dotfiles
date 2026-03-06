return {
    {
        -- writing focus
        'folke/zen-mode.nvim',
        opts = {
            window = {
                backdrop = 1,
                height = 0.95,
                options = {
                    number = false,
                    relativenumber = false,
                },
            },
            plugins = {
                gitsigns = { enabled = true },
            },
        },
    },
    {
        -- soft wrap long lines
        'manu-mannattil/vim-longlines',
        config = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'pandoc',
                callback = function()
                    vim.cmd('LongLines')
                end,
            })
        end,
    },
    {
        -- smart quotes
        'preservim/vim-textobj-quote',
    },
    {
        -- text formatting for Japanese
        'fuenor/JpFormat.vim',
    },
    {
        -- in-editor markdown preview
        'ellisonleao/glow.nvim',
        ft = { 'markdown', 'pandoc' },
        config = function()
            vim.keymap.set('n', '<leader>p', '<cmd>Glow<CR>')
        end,
    },
    {
        -- web markdown preview
        'iamcco/markdown-preview.nvim',
        build = 'cd app && yarn install',
        config = function()
            vim.g.mkdp_auto_start = false
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_filetypes = { 'markdown', 'pandoc' }
        end,
    },
}
