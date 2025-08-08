-- luacheck: globals vim
local plugins = {}

-- thesaurus utility
plugins['ron89/thesaurus_query.vim'] = {
    init = function()
        local bind = require('util.bind')
        local g = vim.g
        -- Disable default keybinds
        g.tq_map_keys = 0

        -- Use custom keybind
        bind.nmap('<leader>t', '<cmd>ThesaurusQueryReplaceCurrentWord<CR>')
    end,
}

-- soft wrap
plugins['manu-mannattil/vim-longlines'] = {}

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

return plugins
