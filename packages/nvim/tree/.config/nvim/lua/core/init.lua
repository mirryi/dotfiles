-- luacheck: globals vim use
local cmd, fn = vim.cmd, vim.fn

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
    M.project()
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

-- {{{ M.project
M.project = function()
    local project = require('core.project')
    project.setup()
end
-- }}}

-- {{{ M.plugins
M.plugins = function()
    local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        local execute = vim.api.nvim_command
        execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
        execute('packadd packer.nvim')
    end
    cmd([[packadd packer.nvim]])

    local packer = require('packer')
    packer.startup(function()
        use { 'wbthomason/packer.nvim', opt = true }
        for _, module in ipairs(modules) do
            for name, conf in pairs(require(module)) do
                local spec = vim.tbl_extend('force', { name }, conf)
                use(spec)
            end
        end
    end, {
        config = {
            display = {
                open_fn = function()
                    return require('packer.util').float { border = 'single' }
                end,
            },
        },
    })
end
-- }}}

return M
