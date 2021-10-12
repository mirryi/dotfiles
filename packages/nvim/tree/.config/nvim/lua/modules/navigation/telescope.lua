local builtin = require('telescope.builtin')

local M = { lsp = {} }

M.files = function()
	builtin.find_files({
		find_command = { 'rg', '--ignore', '--hidden', '--files', '--follow', '-g!.git' },
	})
end

M.git_files = function()
	builtin.git_files()
end

M.oldfiles = function()
	builtin.oldfiles()
end

M.filebrowser = function()
	builtin.file_browser()
end

M.ripgrep = function()
	builtin.live_grep()
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

M.lsp.diagnostics = function()
	builtin.lsp_document_diagnostics()
end

M.lsp.workspace_diagnostics = function()
	builtin.lsp_workspace_diagnostics()
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

M.lsp.code_actions = function()
	builtin.lsp_code_actions()
end

M.lsp.range_actions = function()
	builtin.lsp_range_code_actions()
end

return M
