return {
    {
        -- highlight same item instances
        'RRethy/vim-illuminate',
        config = function()
            vim.keymap.set('n', '<C-.>', function()
                require('illuminate').next_reference { wrap = true }
            end)
            vim.keymap.set('n', '<C-,>', function()
                require('illuminate').next_reference { reverse = true, wrap = true }
            end)
        end,
    },
    {
        -- comment and uncomment with keybindings
        'numToStr/Comment.nvim',
        opts = {},
    },
    {
        -- easy text alignment
        'junegunn/vim-easy-align',
        config = function()
            vim.keymap.set('n', 'gA', '<Plug>(EasyAlign)')
            vim.keymap.set('v', 'gA', '<Plug>(EasyAlign)')
        end,
    },
    {
        -- toggle between short/long constructs
        'AndrewRadev/splitjoin.vim',
        config = function()
            -- Disable default mappings
            vim.g.splitjoin_split_mapping = ''
            vim.g.splitjoin_join_mapping = ''

            -- Use custom mappings
            vim.keymap.set('n', '<leader>j', '<cmd>SplitjoinJoin<CR>')
            vim.keymap.set('n', '<leader>S', '<cmd>SplitjoinSplit<CR>')
        end,
    },
    {
        -- more surround movements
        'kylechui/nvim-surround',
        opts = {
            surrounds = {
                ['a'] = {
                    add = { '⟨', '⟩' },
                },
            },
        },
    },
    {
        -- custom text objects
        'kana/vim-textobj-user',
        config = function()
            vim.fn['textobj#user#plugin']('braces', {
                angle = {
                    pattern = { '⟨', '⟩' },
                    ['select-a'] = 'aa',
                    ['select-i'] = 'ia',
                },
            })
        end,
    },
    {
        -- tab-out of parentheses
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabkey = '<C-n>',
                backwards_tabkey = '<C-b>',
                act_as_tab = false,
                act_as_shift_tab = false,
                enable_backwards = true,
                completion = false,
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' },
                    { open = '$', close = '$' },
                },
                ignore_beginning = true,
                exclude = {},
            }
        end,
        after = { 'nvim-treesitter' },
    },
    {
        -- better folding
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            -- vim.wo.foldcolumn = '1'
            -- vim.wo.foldenable = true
            -- vim.wo.foldlevel = 99

            require('ufo').setup {
                provider_selector = function(_bufnr, filetype)
                    return ({
                        reason = { 'indent' },
                    })[filetype]
                end,
            }
        end,
    },
}
