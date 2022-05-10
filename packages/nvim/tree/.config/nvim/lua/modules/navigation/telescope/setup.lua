local telescope = require('telescope')
local trouble = require('trouble.providers.telescope')

telescope.setup {
    defaults = {
        mappings = {
            i = { ['<c-t>'] = trouble.open_with_trouble },
            n = { ['<c-t>'] = trouble.open_with_trouble },
        },
    },
    pickers = {
        find_files = { theme = 'ivy' },
        git_files = { theme = 'ivy' },
        oldfiles = { theme = 'ivy' },
        live_grep = { theme = 'ivy' },
        buffers = { theme = 'ivy' },
        marks = { theme = 'ivy' },
        registers = { theme = 'ivy' },
        commands = { theme = 'ivy' },
        command_history = { theme = 'ivy' },
        help = { theme = 'ivy' },
        man = { theme = 'ivy' },
        lsp_definitions = { theme = 'ivy' },
        lsp_references = { theme = 'ivy' },
        lsp_document_symbols = { theme = 'ivy' },
        lsp_workspace_symbols = { theme = 'ivy' },
    },
    extensions = {
        file_browser = { theme = 'ivy' },
        ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
        },
    },
}

telescope.load_extension('fzy_native')
telescope.load_extension('file_browser')
telescope.load_extension('ui-select')
