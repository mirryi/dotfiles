-- luacheck: globals vim
local plugins = {}

-- thesaurus utility
plugins['ron89/thesaurus_query.vim'] = {
    init = function()
        -- Disable default keybinds
        vim.g.tq_map_keys = 0

        -- Use custom keybind
        vim.keymap.set('n', '<leader>t', '<cmd>ThesaurusQueryReplaceCurrentWord<CR>')
    end,
}

-- soft wrap
plugins['manu-mannattil/vim-longlines'] = {
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'pandoc',
            callback = function()
                vim.cmd('LongLines')
            end,
        })
    end,
}

-- writing focus
plugins['folke/zen-mode.nvim'] = {
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
}

plugins['preservim/vim-textobj-quote'] = {}

return plugins
