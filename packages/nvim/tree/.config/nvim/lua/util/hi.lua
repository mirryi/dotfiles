-- luacheck: globals vim
local M = {}

-- Link a highlight group.
M.link = setmetatable({}, {
    __newindex = function(_, groupm, groupn)
        local cmd = { 'hi', 'link', groupm, groupn }
        vim.cmd(table.concat(cmd, ' '))
    end,
})

return M
