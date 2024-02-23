local plugins = {}

plugins['sainnhe/gruvbox-material'] = {
    config = function()
        -- luacheck: globals vim
        local U = require('util')

        -- Initialize colorscheme
        local shared = require('modules.theme.gruvbox.shared')
        shared.colorscheme('dark', 'material', 'medium')

        -- Initialize lualine
        local lualine = require('modules.theme.common.lualine')
        lualine.setup('gruvbox-material')

        -- Treesitter highlight modifications
        local hilink = U.hi.link

        hilink.TSField = 'Fg'
        -- hilink.TSKeyword = 'RedItalic'
        hilink.TSKeywordOperator = 'Orange'
        hilink.TSNamespace = 'Orange'
        hilink.TSProperty = 'Fg'
        hilink.TSString = 'GreenItalic'
        hilink.TSType = 'Fg'
        hilink.TSTypeBuiltin = 'Yellow'
        hilink.TSVariableBuiltin = 'BlueItalic'
        hilink.TSConstant = 'Purple'

        hilink.TSFuncMacro = 'Purple'
        hilink.TSFuncBuiltin = 'Purple'
    end,
}

return plugins
