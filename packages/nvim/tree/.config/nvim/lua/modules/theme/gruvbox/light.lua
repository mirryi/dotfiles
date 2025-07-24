local plugins = {}

plugins['sainnhe/gruvbox-material'] = {
    config = function()
        -- Initialize colorscheme
        local shared = require('modules.theme.gruvbox.shared')
        shared.colorscheme('light', 'material', 'medium')

        -- Initialize lualine
        local lualine = require('modules.theme.common.lualine')
        lualine.setup('gruvbox-material')
    end,
}

return plugins
