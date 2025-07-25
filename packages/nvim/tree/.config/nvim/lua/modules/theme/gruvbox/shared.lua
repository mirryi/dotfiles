-- luacheck: globals vim
local g, o = vim.g, vim.o
local exec = vim.api.nvim_exec

local M = {}

M.colorscheme = function(dl, palette, bg)
    -- Use gruvbox-material colorscheme
    o.background = dl
    g.gruvbox_material_palette = palette
    g.gruvbox_material_background = bg

    -- Enable bold function name
    -- g.gruvbox_material_enable_bold = 1

    -- Enable italics
    g.gruvbox_material_enable_italic = 1
    g.gruvbox_material_disable_italic_comment = 0

    -- Enable diagnostic highlighting
    g.gruvbox_material_diagnostic_text_highlight = 1
    g.gruvbox_material_diagnostic_line_highlight = 1

    -- Better performance setting
    g.gruvbox_material_better_performance = 1

    -- Initialize colorscheme
    exec(
        [[
try
  colorscheme gruvbox-material
  catch
endtry
]],
        true
    )

    -- Treesitter highlight modifications
    local U = require('util')
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
end

return M
