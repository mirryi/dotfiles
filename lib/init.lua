-- Table utilities
function table.push(t, v)
    table.insert(t, v)
    return t
end

function table.front(t)
    return t[1]
end

if not table.clear then
    function table.clear(t)
        local k = next(t)
        while k ~= nil do
            t[k] = nil
            k = next(t)
        end
    end
end

function table.overwrite(m, n)
    for k, v in pairs(n) do
        m[k] = v
    end
end

function table.extend(t, ...)
    for _, v in ipairs { ... } do
        table.push(t, v)
    end
end

-- Utilities
local M = {}

M.require_opt = function(p)
    local status, import = pcall(require, p)
    if status then return import end
    return nil
end

M.file_exists = function(path)
    local f = io.open(path, 'r')
    if f then
        f:close()
        return true
    end
    return false
end

M.list_dirs = function(path)
    local dirs = {}
    local p = io.popen('ls -1 "' .. path .. '"')
    for line in p:lines() do
        local attr = io.popen('test -d "' .. path .. '/' .. line .. '" && echo d')
        if attr:read('*l') == 'd' then
            table.push(dirs, line)
        end
        attr:close()
    end
    p:close()
    return dirs
end

M.use_profile = function(name)
    local profile = require('profile')[name]
    if profile then
        pkg.variables:overwrite(profile)
    end
end

M.use_variables = function()
    local vars = require('variables')
    pkg.variables:overwrite(vars)
end

return M
