-- luacheck: globals vim
local lualine = require('lualine')

local M = {}

local wordcount = function()
    local filetypes = { 'markdown', 'pandoc', 'txt' }
    if not (vim.tbl_contains(filetypes, vim.bo.filetype)) then
        return ''
    end

    local words = vim.fn.wordcount().visual_words
    if words == nil then
        words = vim.fn.wordcount().words
    end

    if words == 1 then
        return tostring(words) .. ' word'
    else
        return tostring(words) .. ' words'
    end
end

M.setup = function(theme)
    lualine.setup {
        options = { theme = theme },
        sections = {
            lualine_c = { { 'diagnostics', sources = { 'nvim_diagnostic' } }, 'filename', { wordcount } },
        },
    }
end

return M
