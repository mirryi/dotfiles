return function(dl, palette, bg)
    return {
        {
            'sainnhe/gruvbox-material',
            config = function()
                vim.o.background = dl
                vim.g.gruvbox_material_palette = palette
                vim.g.gruvbox_material_background = bg

                -- enable italics
                vim.g.gruvbox_material_enable_italic = 1
                vim.g.gruvbox_material_disable_italic_comment = 0

                -- enable diagnostic highlighting
                vim.g.gruvbox_material_diagnostic_text_highlight = 1
                vim.g.gruvbox_material_diagnostic_line_highlight = 1

                -- better performance setting
                vim.g.gruvbox_material_better_performance = 1

                -- initialize colorscheme
                pcall(vim.cmd.colorscheme, 'gruvbox-material')

                -- highlight modifications
                local hi = require('util.hi')

                hi.link.TSKeywordOperator = 'Orange'
                hi.link.TSNamespace = 'Orange'
                hi.link.TSProperty = 'Fg'
                hi.link.TSString = 'GreenItalic'
                hi.link.TSType = 'Fg'
                hi.link.TSTypeBuiltin = 'Yellow'
                hi.link.TSVariableBuiltin = 'BlueItalic'
                hi.link.TSConstant = 'Purple'

                hi.link.TSFuncMacro = 'Purple'
                hi.link.TSFuncBuiltin = 'Purple'
            end,
        },
    }
end
