-- luacheck: globals vim
local plugins = {}

-- statusline
plugins['hoob3rt/lualine.nvim'] = { dependencies = { 'kyazdani42/nvim-web-devicons', 'arkav/lualine-lsp-progress' } }

-- git signs in the signcolumn
plugins['lewis6991/gitsigns.nvim'] = {
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local gitsigns = require('gitsigns')
        gitsigns.setup()
    end,
}

-- sane buffer tabline
plugins['romgrk/barbar.nvim'] = {
    config = function()
        local bind = require('util.bind')
        local nmap = bind.nmap

        require('barbar').setup {
            -- Enable animations
            animation = true,
            -- Enable close button
            closable = true,
            -- Disable icons
            icons = { filetype = { enabled = false } },
            -- Letters to assign buffer in order
            letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
            -- Maximum padding width surrounding each tab
            maximum_padding = 4,
            -- Set buffer letters first in terms of their name
            semantic_letters = true,
            -- Exclude quickfix list
            exclude_ft = { 'qf' },
        }

        -- Select tab
        nmap('<C-s>', '<cmd>BufferPick<CR>', { silent = true })
        -- Move to previous/next tab
        nmap('t,', '<cmd>BufferPrevious<CR>', { silent = true })
        nmap('t.', '<cmd>BufferNext<CR>', { silent = true })
        -- Re-order to previous/next
        nmap('t<', '<cmd>BufferMovePrevious<CR>', { silent = true })
        nmap('t>', '<cmd>BufferMoveNext<CR>', { silent = true })
        -- Goto buffer in position
        nmap('t1', '<cmd>BufferGoto 1<CR>', { silent = true })
        nmap('t2', '<cmd>BufferGoto 2<CR>', { silent = true })
        nmap('t3', '<cmd>BufferGoto 3<CR>', { silent = true })
        nmap('t4', '<cmd>BufferGoto 4<CR>', { silent = true })
        nmap('t5', '<cmd>BufferGoto 5<CR>', { silent = true })
        nmap('t6', '<cmd>BufferGoto 6<CR>', { silent = true })
        nmap('t7', '<cmd>BufferGoto 7<CR>', { silent = true })
        nmap('t8', '<cmd>BufferGoto 8<CR>', { silent = true })
        nmap('t9', '<cmd>BufferLast<CR>', { silent = true })
        -- Close buffer
        nmap('tc', ' <cmd>BufferClose<CR>', { silent = true })
    end,
}

-- minimap
-- plugins['wfxr/minimap.vim'] = {
-- config = function()
-- local bind = require('util.bind')
-- -- Toggle minimap
-- bind.nmap('<leader>m', '<cmd>MinimapToggle<CR>', { silent = true })
-- end,
-- }

-- wildmenu enhancements
plugins['gelguy/wilder.nvim'] = {
    config = function()
        local cmd, fn = vim.cmd, vim.fn

        fn['wilder#enable_cmdline_enter']()
        cmd([[set wildcharm=<Tab>]])

        cmd([[cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"]])
        cmd([[cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"]])

        fn['wilder#set_option']('modes', { '/', '?', ':' })

        vim.api.nvim_exec(
            [[
                call wilder#set_option('renderer', wilder#popupmenu_renderer({'highlighter': wilder#basic_highlighter(), 'left': [wilder#popupmenu_devicons()]}))
                call wilder#set_option('pipeline', [wilder#branch([ wilder#check({_, x -> empty(x)}), wilder#history(), ], wilder#cmdline_pipeline(), wilder#search_pipeline())])
            ]],
            false
        )
    end,
}

-- popup with keybind suggestions
plugins['folke/which-key.nvim'] = {
    config = function()
        local whichkey = require('which-key')

        vim.o.timeoutlen = 500
        whichkey.setup {
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
            },
        }
    end,
}

-- fancy notifications
plugins['rcarriga/nvim-notify'] = {}

return plugins
