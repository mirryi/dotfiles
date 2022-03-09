local fs = require('util.fs')
local json = require('util.json')
local prompt = require('util.prompt')

local M = {}

M.default_opts = {
    enabled = true,
    trust = {
        file = vim.fn.stdpath('cache') .. '/project/trust.json',
    },
    config = {
        pathfn = function(path)
            return path .. '/vim'
        end,
        modname = 'project',
    },
}

M.fill_opts = function(_opts)
    local opts = vim.deepcopy(_opts)
    if opts == nil then
        return M.default_opts
    end

    if opts.enabled == nil then
        opts.enabled = true
    end

    if opts.trust == nil then
        opts.trust = M.default_opts.trust
    else
        if opts.trust.file == nil then
            opts.trust.file = M.default_opts.trust.file
        end
    end

    if opts.config == nil then
        opts.config = M.default_opts.config
    else
        if opts.config.pathfn == nil then
            opts.config.pathfn = M.default_opts.config.pathfn
        end
        if opts.config.modname == nil then
            opts.config.modname = M.default_opts.config.modname
        end
    end

    return opts
end

M.exec_prompt = function(opts, d, path)
    local config_pathfn = opts.config.pathfn or M.default_opts.config.pathfn
    local modname = opts.config.modname or M.default_opts.config.modname

    local modfile = config_pathfn(path) .. '/' .. modname .. '.lua'
    if not fs.exists(modfile) then
        return
    end

    if not d[path] then
        prompt.prompt_yn(
            { prompt = 'Trust the project configuration: ' .. modfile .. ' [Y/n]: ' },
            function(input)
                if input then
                    M.trust(opts, d, path)
                    M.exec_unchecked(opts, modfile)
                else
                    M.distrust(opts, d, path)
                end
            end
        )
    elseif d[path].trust then
        M.exec_unchecked(opts, modfile)
    end
end

M.exec_unchecked = function(_opts, modfile)
    dofile(modfile)
end

M.trust = function(_opts, d, path)
    d[path] = {
        trust = true,
    }
end

M.distrust = function(_opts, d, path)
    d[path] = {
        trust = false,
    }
end

M.load = function(opts)
    local file = io.open(opts.trust.file or M.default_opts.trust.file, 'r')
    if file == nil then
        return {}
    else
        local s = file:read('a')
        file:close()
        return json.decode(s)
    end
end

M.store = function(opts, d)
    local trust_file = opts.trust.file or M.default_opts.trust.file
    local s = json.encode(d)

    local file = fs.create_all(trust_file)
    file:write(s)
    file:close()
end

return M
