return {
    -- agda
    {
        'isovector/cornelis',
        build = { 'stack build' },
        dependencies = { 'kana/vim-textobj-user', 'neovimhaskell/nvim-hs.vim', 'liuchengxu/vim-which-key' },
        init = function() end,
        config = function()
            vim.keymap.set('n', '<leader>al', '<cmd>CornelisLoad<CR>')
            vim.keymap.set('n', '<leader>aG', '<cmd>CornelisGoals<CR>')
            vim.keymap.set('n', '<leader>aR', '<cmd>CornelisRestart<CR>')
            vim.keymap.set('n', '<leader>aA', '<cmd>CornelisAbort<CR>')
            vim.keymap.set('n', '<leader>as', '<cmd>CornelisSolve<CR>')
            vim.keymap.set('n', '<leader>ad', '<cmd>CornelisGoToDefinition<CR>')
            vim.keymap.set('n', '<leader>aN', '<cmd>CornelisPrevGoal<CR>')
            vim.keymap.set('n', '<leader>an', '<cmd>CornelisNextGoal<CR>')
            vim.keymap.set('n', '<leader>aM', '<cmd>CornelisQuestionToMeta<CR>')
            vim.keymap.set('n', '<leader>aC', '<cmd>CornelisCloseInfoWindows<CR>')

            vim.keymap.set('n', '<leader>ag', '<cmd>CornelisGive<CR>')
            vim.keymap.set('n', '<leader>ar', '<cmd>CornelisRefine<CR>')
            vim.keymap.set('n', '<leader>aL', '<cmd>CornelisElaborate<CR>')
            vim.keymap.set('n', '<leader>aa', '<cmd>CornelisAuto<CR>')
            vim.keymap.set('n', '<leader>ac', '<cmd>CornelisMakeCase<CR>')
            vim.keymap.set('n', '<leader>ae', '<cmd>CornelisTypeContext<CR>')
            vim.keymap.set('n', '<leader>ai', '<cmd>CornelisTypeInfer<CR>')
            vim.keymap.set('n', '<leader>aE', '<cmd>CornelisTypeContextInfer<CR>')
            vim.keymap.set('n', '<leader>aN', '<cmd>CornelisNormalize<CR>')
            vim.keymap.set('n', '<leader>aw', '<cmd>CornelisWhyInScope<CR>')
        end,
    },

    -- csv
    {
        'mechatroner/rainbow_csv',
        ft = { 'csv' },
    },

    -- graphviz
    {
        'wannesm/wmgraphviz.vim',
    },

    -- forester
    {
        'kentookura/forester.nvim',
        ft = { 'forester' },
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
        opts = {},
        -- TODO set up completion
    },

    -- i3 configuration
    {
        'mboughaba/i3config.vim',
    },

    -- markdown
    {
        'vim-pandoc/vim-pandoc',
        dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
    },
    {
        'vim-pandoc/vim-rmarkdown',
        dependencies = { 'vim-pandoc/vim-pandoc' },
        ft = { 'rmarkdown' },
    },

    -- nginx
    {
        'chr4/nginx.vim',
    },

    -- nickel
    {
        'nickel-lang/vim-nickel',
    },

    -- nusmv
    {
        'wannesm/wmnusmv.vim',
    },

    -- reasonml
    {
        'arrowresearch/vim-reason',
    },

    -- rocq
    {
        'whonore/Coqtail',
    },

    -- rust
    {
        'saecki/crates.nvim',
        ft = { 'toml' },
        opts = {},
    },

    -- smtlib2
    {
        'bohlender/vim-smt2',
    },

    -- TeX
    {
        'lervag/vimtex',
        config = function()
            local g = vim.g
            g.tex_flavor = 'latex'
            g.vimtex_enabled = 1

            -- Syntax options
            g.vimtex_syntax_enabled = 1
            g.vimtex_syntax_custom_cmds = {
                { name = 'vert', mathmode = 1, conceal = 1, concealchar = '|' },
                { name = 'textbf', mathmode = 1, conceal = 1, argstyle = 'bold' },
            }

            -- Fold options
            g.vimtex_fold_enabled = 1
            g.vimtex_fold_levelmarker = ':'
            g.vimtex_fold_types = { items = { enabled = 0 } }

            -- View options
            g.vimtex_view_method = 'zathura'

            local au_group = vim.api.nvim_create_augroup('vimtex_events', {})
            vim.api.nvim_create_autocmd('User', {
                pattern = 'VimtexEventView',
                group = au_group,
                command = 'call b:vimtex.viewer.xdo_focus_vim()',
            })
        end,
    },

    {
        -- math preview on hover
        'jbyuki/nabla.nvim',
        ft = { 'latex' },
        config = function()
            vim.keymap.set('n', '<leader>lf', function()
                require('nabla').popup()
            end)
        end,
    },

    -- typst
    {
        'kaarmu/typst.vim',
        ft = { 'typst' },
    },
    {
        -- live preview
        'chomosuke/typst-preview.nvim',
        ft = { 'typst' },
    },
}
