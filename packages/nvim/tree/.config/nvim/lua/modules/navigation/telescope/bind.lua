local pickers = require('modules.navigation.telescope.pickers')

local with_non = function(opts)
    local f = opts[4]
    opts[4] = function(_)
        f()
    end
    return opts
end
local with_rel = function(opts)
    local f = opts[4]
    opts[4] = function(o)
        f(o.fargs[1] ~= 'absolute')
    end

    opts[5] = {
        nargs = '?',
        complete = function(_, _, _)
            return { 'absolute' }
        end,
    }
    return opts
end

local defs = {
    commands = {
        with_rel { 'Files', 'Open file picker', false, pickers.files },
        with_rel { 'FileBrowser', 'Open file browser', false, pickers.filebrowser },
        with_rel { 'Ripgrep', 'Open recent file picker', false, pickers.ripgrep },

        with_non { 'GitFiles', 'Open git file picker', false, pickers.git_files },
        with_non { 'RecentFiles', 'Open recent file picker', false, pickers.oldfiles },

        with_non { 'Buffers', 'Open buffer picker', false, pickers.buffers },
        with_non { 'Registers', 'Open register picker', false, pickers.registers },

        with_non { 'Commands', 'Open command picker', false, pickers.commands },
        with_non { 'CommandHistory', 'Open command history picker', false, pickers.command_history },

        with_non { 'HelpTags', 'Open help tag picker', false, pickers.help },
        with_non { 'ManPages', 'Open man page picker', false, pickers.man_pages },

        -- with_non { 'Marks', 'Open mark picker', false, pickers.marks },
        -- with_non { 'Ctags', 'Open ctag picker', false, pickers.ctags },
        -- with_non { 'Quickfixes', 'Open quickfix picker', false, pickers.quickfix },

        with_non { 'LspDefinitions', 'Open LSP definitions picker', false, pickers.lsp.definitions },
        with_non { 'LspReferences', 'Open LSP references picker', false, pickers.lsp.references },
        with_non { 'LspDocSymbols', 'Open LSP document symbols picker', false, pickers.lsp.symbols },
        with_non { 'LspWsSymbols', 'Open LSP workspace symbols picker', false, pickers.lsp.workspace_symbols },
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

local command = require('util.command')
local bind = require('util.bind')

for _, opts in ipairs(defs.commands) do
    command.new_cmd(opts[1], opts[2], opts[3], opts[4], opts[5])
end

for _, opts in ipairs(defs.binds) do
    bind.nmap(opts[1], '<cmd>' .. opts[2] .. '<CR>')
end
