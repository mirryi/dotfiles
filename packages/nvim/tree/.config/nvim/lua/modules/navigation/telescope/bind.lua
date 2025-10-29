local pickers = require('modules.navigation.telescope.pickers')

local with_non = function(opts)
    return {
        opts[1],
        { desc = opts[2] },
        function(_)
            opts[3]()
        end,
    }
end
local with_rel = function(opts)
    return {
        opts[1],
        {
            desc = opts[2],
            nargs = '?',
            complete = function(_, _, _)
                return { 'absolute' }
            end,
        },
        function(o)
            opts[3](o.fargs[1] ~= 'absolute')
        end,
    }
end

local defs = {
    commands = {
        with_rel { 'Files', 'Open file picker', pickers.files },
        with_rel { 'FileBrowser', 'Open file browser', pickers.filebrowser },
        with_rel { 'Ripgrep', 'Open recent file picker', pickers.ripgrep },

        with_non { 'GitFiles', 'Open git file picker', pickers.git_files },
        with_non { 'RecentFiles', 'Open recent file picker', pickers.oldfiles },

        with_non { 'Buffers', 'Open buffer picker', pickers.buffers },
        with_non { 'Registers', 'Open register picker', pickers.registers },

        with_non { 'Commands', 'Open command picker', pickers.commands },
        with_non { 'CommandHistory', 'Open command history picker', pickers.command_history },

        with_non { 'Help', 'Open help tag picker', pickers.help },
        with_non { 'ManPages', 'Open man page picker', pickers.man_pages },

        with_non { 'LspDefinitions', 'Open LSP definitions picker', pickers.lsp.definitions },
        with_non { 'LspReferences', 'Open LSP references picker', pickers.lsp.references },
        with_non { 'LspDocSymbols', 'Open LSP document symbols picker', pickers.lsp.symbols },
        with_non { 'LspWsSymbols', 'Open LSP workspace symbols picker', pickers.lsp.workspace_symbols },
    },
    binds = {
        { '<C-p>', 'Files' },
        { '<leader>ff', 'Files' },
        { '<leader>fF', 'Files absolute' },
        { '<leader>fg', 'GitFiles' },
        { '<leader>fh', 'RecentFiles' },
        { '<leader>fb', 'FileBrowser' },
        { '<leader>fB', 'FileBrowser absolute' },
        { '<leader>fr', 'Ripgrep' },
        { '<leader>fR', 'Ripgrep absolute' },
        { '<leader>fu', 'Buffers' },
        { '<leader>fe', 'Registers' },
        { '<leader>fc', 'Commands' },
        { '<leader>fC', 'CommandHistory' },
    },
}

for _, opts in ipairs(defs.commands) do
    local name = opts[1]
    local opt = opts[2]
    local f = opts[3]
    vim.api.nvim_create_user_command(name, f, opt)
end

for _, opts in ipairs(defs.binds) do
    vim.keymap.set('n', opts[1], '<cmd>' .. opts[2] .. '<CR>')
end
