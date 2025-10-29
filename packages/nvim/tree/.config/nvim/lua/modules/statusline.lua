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
        vim.keymap.set('n', 'ts', '<cmd>BufferPick<CR>')
        -- Move to previous/next tab
        vim.keymap.set('n', 't,', '<cmd>BufferPrevious<CR>')
        vim.keymap.set('n', 't.', '<cmd>BufferNext<CR>')
        -- Re-order to previous/next
        vim.keymap.set('n', 't<', '<cmd>BufferMovePrevious<CR>')
        vim.keymap.set('n', 't>', '<cmd>BufferMoveNext<CR>')
        -- Goto buffer in position
        vim.keymap.set('n', 't1', '<cmd>BufferGoto 1<CR>')
        vim.keymap.set('n', 't2', '<cmd>BufferGoto 2<CR>')
        vim.keymap.set('n', 't3', '<cmd>BufferGoto 3<CR>')
        vim.keymap.set('n', 't4', '<cmd>BufferGoto 4<CR>')
        vim.keymap.set('n', 't5', '<cmd>BufferGoto 5<CR>')
        vim.keymap.set('n', 't6', '<cmd>BufferGoto 6<CR>')
        vim.keymap.set('n', 't7', '<cmd>BufferGoto 7<CR>')
        vim.keymap.set('n', 't8', '<cmd>BufferGoto 8<CR>')
        vim.keymap.set('n', 't9', '<cmd>BufferLast<CR>')
        -- Close buffer
        vim.keymap.set('n', 'tc', ' <cmd>BufferClose<CR>')
        vim.keymap.set('n', 'tC', ' <cmd>BufferCloseAllButCurrent<CR>')
    end,
}

-- wildmenu enhancements
if not vim.g.vscode then
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
end

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
-- plugins['rcarriga/nvim-notify'] = {}

return plugins
