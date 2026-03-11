local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
local extensions = require('telescope').extensions

local M = { lsp = {} }

local function cwd_of(relative)
    return relative and utils.buffer_dir() or nil
end

function M.files(relative)
    builtin.find_files {
        cwd = cwd_of(relative),
        find_command = { 'rg', '--ignore', '--hidden', '--files', '--follow', '-g!.git' },
    }
end

function M.git_files()
    builtin.git_files { additional_args = { '--hidden' } }
end

function M.oldfiles()
    builtin.oldfiles()
end

function M.filebrowser(relative)
    extensions.file_browser.file_browser { cwd = cwd_of(relative), hidden = true }
end

function M.ripgrep(relative)
    builtin.live_grep { cwd = cwd_of(relative), additional_args = { '--hidden' } }
end

function M.buffers()
    builtin.buffers()
end
function M.registers()
    builtin.registers()
end
function M.commands()
    builtin.commands()
end
function M.command_history()
    builtin.command_history()
end
function M.help()
    builtin.help_tags()
end
function M.man_pages()
    builtin.man_pages()
end

function M.lsp.definitions()
    builtin.lsp_definitions()
end
function M.lsp.references()
    builtin.lsp_references()
end
function M.lsp.symbols()
    builtin.lsp_document_symbols()
end
function M.lsp.workspace_symbols()
    builtin.lsp_workspace_symbols()
end

return M
