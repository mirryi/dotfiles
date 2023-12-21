-- luacheck: globals vim use
local modules = {
    'modules.fix',
    'modules.statusline',
    'modules.display',
    'modules.navigation',
    'modules.language',
    'modules.lsp',
    'modules.completion',
    'modules.editing',
    'modules.writing',
    'modules.tools',
    'modules.theme',
}

local M = {}

-- {{{ M.init
M.init = function()
    M.global()
    M.bindings()
    M.plugins()
end
-- }}}

-- {{{ M.global
M.global = function()
    require('core.global')
end
-- }}}

-- {{{ M.bindings
M.bindings = function()
    require('core.bindings')
end
-- }}}

-- {{{ M.plugins
M.plugins = function()
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system {
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', -- latest stable release
            lazypath,
        }
    end
    vim.opt.rtp:prepend(lazypath)

    -- Gather plugin specs
    local plugins = {}
    for _, module in ipairs(modules) do
        for name, spec in pairs(require(module)) do
            plugins[#plugins + 1] = vim.tbl_extend('force', { name }, spec)
        end
    end

    -- Initialize lazy
    local lazy = require('lazy')
    lazy.setup(plugins)
end
-- }}}

return M
