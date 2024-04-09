local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
local extensions = require('telescope').extensions

local M = { lsp = {} }

local cwd_of = function(relative)
    return relative and utils.buffer_dir() or nil
end

M.files = function(relative)
    builtin.find_files {
        cwd = cwd_of(relative),
        find_command = { 'rg', '--ignore', '--hidden', '--files', '--follow', '-g!.git' },
    }
end

M.git_files = function()
    builtin.git_files { additional_args = { '--hidden' } }
end

M.oldfiles = function(relative)
    builtin.oldfiles { cwd = cwd_of(relative) }
end

M.filebrowser = function(relative)
    extensions.file_browser.file_browser { cwd = cwd_of(relative) }
end

M.ripgrep = function(relative)
    builtin.live_grep { cwd = cwd_of(relative), additional_args = { '--hidden' } }
end

M.buffers = function()
    builtin.buffers()
end

M.marks = function()
    builtin.marks()
end

M.ctags = function()
    builtin.tags()
end

M.quickfix = function()
    builtin.quickfix()
end

M.registers = function()
    builtin.registers()
end

M.commands = function()
    builtin.commands()
end

M.command_history = function()
    builtin.command_history()
end

M.help = function()
    builtin.help_tags()
end

M.man_pages = function()
    builtin.man_pages()
end

M.lsp.definitions = function()
    builtin.lsp_definitions()
end

M.lsp.references = function()
    builtin.lsp_references()
end

M.lsp.symbols = function()
    builtin.lsp_document_symbols()
end

M.lsp.workspace_symbols = function()
    builtin.lsp_workspace_symbols()
end

return M
