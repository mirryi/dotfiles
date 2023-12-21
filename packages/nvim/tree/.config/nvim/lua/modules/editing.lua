-- luacheck: globals vim

local plugins = {}

-- preview search and replace
plugins['markonm/traces.vim'] = {}

-- comment and uncomment with keybindings
plugins['scrooloose/nerdcommenter'] = {
    -- This plugin binds <leader>c<space>
    config = function()
        local g = vim.g
        g.NERDSpaceDelims = 1
    end,
}

-- automated text table spacing
plugins['godlygeek/tabular'] = {
    ft = { 'asciidoc', 'markdown', 'pandoc', 'rmarkdown', 'text', 'tex' },
}

-- easy text alignment
plugins['junegunn/vim-easy-align'] = {
    config = function()
        local bind = require('util.bind')

        bind.nmap('gA', '<Plug>(EasyAlign)')
        bind.vmap('gA', '<Plug>(EasyAlign)')
    end,
}

-- toggle between short/long constructs
plugins['AndrewRadev/splitjoin.vim'] = {
    config = function()
        local g = vim.g
        local bind = require('util.bind')

        -- Disable default mappings
        g.splitjoin_split_mapping = ''
        g.splitjoin_join_mapping = ''

        -- Use custom mappings
        bind.nmap('<leader>j', '<cmd>SplitjoinJoin<CR>')
        bind.nmap('<leader>S', '<cmd>SplitjoinSplit<CR>')
    end,
}

-- highlight selected ranges
plugins['winston0410/range-highlight.nvim'] = {
    dependencies = { 'winston0410/cmd-parser.nvim' },
    config = function()
        require('range-highlight').setup {}
    end,
}

-- more surround movements
plugins['tpope/vim-surround'] = {}

-- tab-out of parentheses
plugins['abecodes/tabout.nvim'] = {
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
}

-- text formatting for Japanese
plugins['fuenor/JpFormat.vim'] = {}

-- better folding
plugins['kevinhwang91/nvim-ufo'] = {
    dependencies = {'kevinhwang91/promise-async'},
    config = function()
        -- vim.wo.foldcolumn = '1'
        -- vim.wo.foldenable = true
        -- vim.wo.foldlevel = 99

        require('ufo').setup {
            provider_selector = function(_bufnr, filetype)
                return ({
                    dune = '',
                    lua = '',
                    reason = { 'indent' },
                })[filetype]
            end,
        }
    end,
}
-- }}}

return plugins
