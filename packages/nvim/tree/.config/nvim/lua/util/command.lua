--
-- Command utilities.
--
local bind = require('util.bind')

local M = {}

-- Add a new command.
M.new_cmd = function(name, desc, force, f, opts)
    if opts == nil then
        opts = {}
    end

    opts.desc = desc
    opts.force = force
    vim.api.nvim_add_user_command(name, f, opts)
end

M.new_cmd_nmap = function(opts)
    local name = opts.cmd.name
    M.new_cmd(name, opts.desc, opts.cmd.force, opts.cmd.f, opts.cmd.opts)
    bind.nmap(opts.bind.key, '<cmd>' .. name .. '<CR>', opts.bind.opts)
end

return M
