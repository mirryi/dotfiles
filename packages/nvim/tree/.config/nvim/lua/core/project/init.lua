local project = require('core.project.lib')

local M = {}

M.setup = function(_opts)
    local opts = project.fill_opts(_opts)
    if not (opts.enabled or true) then
        return
    end

    local cwd = vim.fn.getcwd()
    local d = project.load(opts)
    project.exec_prompt(opts, d, cwd)
    project.store(opts, d)
end

return M
