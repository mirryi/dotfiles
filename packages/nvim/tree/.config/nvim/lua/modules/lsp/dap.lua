local bind = require('util.bind')
local dap, dapui = require('dap'), require('dapui')

local dap_vt = require('nvim-dap-virtual-text')

dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-vscode',
    name = 'lldb',
}
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
}

dapui.setup()
dap_vt.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

vim.cmd([[ command! Debug :lua require('dap').continue() ]])
vim.cmd([[ command! DebugUi :lua require('dapui').toggle() ]])
vim.cmd([[ command! DebugRepl :lua require('dap').repl.toggle() ]])

bind.nmap('gBB', [[<cmd>Debug<CR>]])
bind.nmap('gBU', [[<cmd>DebugUi<CR>]])
bind.nmap('gBR', [[<cmd>DebugRepl<CR>]])

vim.cmd([[ command! DebugBreakpoint :lua require('dap').toggle_breakpoint() ]])
vim.cmd([[ command! DebugStepOver :lua require('dap').step_over() ]])
vim.cmd([[ command! DebugStepInto :lua require('dap').step_into() ]])
vim.cmd([[ command! DebugStepOut :lua require('dap').step_out() ]])
vim.cmd([[ command! DebugStepBack :lua require('dap').step_back() ]])

bind.nmap('gbb', [[ <cmd>DebugBreakpoint<CR> ]])
bind.nmap('gbo', [[ <cmd>DebugStepOver<CR> ]])
bind.nmap('gbi', [[ <cmd>DebugStepInto<CR> ]])
bind.nmap('gbO', [[ <cmd>DebugStepOut<CR> ]])
bind.nmap('gbB', [[ <cmd>DebugStepBack<CR> ]])
