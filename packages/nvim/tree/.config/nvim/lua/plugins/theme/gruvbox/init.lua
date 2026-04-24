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

                hi.link['@keyword.operator'] = 'Orange'
                hi.link['@module'] = 'Orange'
                hi.link['@property'] = 'Fg'
                hi.link['@string'] = 'GreenItalic'
                hi.link['@type'] = 'Fg'
                hi.link['@type.builtin'] = 'Yellow'
                hi.link['@variable.builtin'] = 'BlueItalic'
                hi.link['@constant'] = 'Purple'

                hi.link['@function.macro'] = 'Purple'
                hi.link['@function.builtin'] = 'Purple'
            end,
        },
    }
end
