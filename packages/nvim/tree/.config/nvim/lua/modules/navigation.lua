-- luacheck: globals vim
local plugins = {}

-- {{{ hop.vim : Jump locations
plugins['phaazon/hop.nvim'] = {
	config = function()
		local hop = require('hop')
		local bind = require('util.bind')

		hop.setup({})
		bind.nmap('<leader>s', '<cmd>lua require("hop").hint_words()<CR>')
	end,
}
-- }}}
-- {{{ vim-gutentag : Tag management
plugins['ludovicchabant/vim-gutentags'] = {
	config = function()
		local g = vim.g
		g.gutentags_cache_dir = g.nvim_cache .. '/gutentags'
	end,
}
-- }}}
-- {{{ telescope.nvim : Fuzzy picker
plugins['nvim-telescope/telescope.nvim'] = {
	requires = {
		{ 'nvim-lua/popup.nvim' },
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope-fzy-native.nvim' },
	},
	config = function()
		local nmap = function(lhs, rhs)
			local bind = require('util.bind')
			bind.nmap(lhs, rhs, { noremap = true })
		end

		local cmd = vim.cmd

		local telescope = require('telescope')
		local trouble = require('trouble.providers.telescope')

		telescope.setup({
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
				file_browser = { theme = 'ivy' },
				live_grep = { theme = 'ivy' },
				buffers = { theme = 'ivy' },
				marks = { theme = 'ivy' },
				registers = { theme = 'ivy' },
				commands = { theme = 'ivy' },
				command_history = { theme = 'ivy' },
				help = { theme = 'ivy' },
				man = { theme = 'ivy' },
				lsp_definitions = { theme = 'ivy' },
				lsp_document_diagnostics = { theme = 'ivy' },
				lsp_workspace_diagnostics = { theme = 'ivy' },
				lsp_references = { theme = 'ivy' },
				lsp_document_symbols = { theme = 'ivy' },
				lsp_workspace_symbols = { theme = 'ivy' },
				lsp_code_actions = { theme = 'cursor' },
				lsp_range_code_actions = { theme = 'cursor' },
			},
		})
		telescope.load_extension('fzy_native')

		-- {{{ File pickers
		-- Files
		-- luacheck: no max_line_length
		cmd([[ command! Files :lua require('modules.navigation.telescope').files() ]])
		nmap('<C-p>', '<cmd>Files<CR>')
		-- Git files
		cmd([[ command! GitFiles :lua require('modules.navigation.telescope').git_files() ]])
		cmd([[ cnoreabbrev GF GitFiles ]])
		nmap('<leader>fg', '<cmd>GitFiles<CR>')
		-- Recent files
		cmd([[ command! RecentFiles :lua require('modules.navigation.telescope').oldfiles() ]])
		nmap('<leader>ff', '<cmd>RecentFiles<CR>')
		-- File browser
		cmd([[ command! FileBrowser :lua require('modules.navigation.telescope').filebrowser() ]])
		nmap('<leader>fb', '<cmd>FileBrowser<CR>')
		-- Use ripgrep to search
		cmd([[ command! Rg :lua require('modules.navigation.telescope').ripgrep() ]])
		nmap('<leader>fr', '<cmd>Rg<CR>')
		-- }}}
		-- {{{ Vim pickers
		-- Buffer picker
		cmd([[ command! Buffers :lua require('modules.navigation.telescope').buffers() ]])
		nmap('<leader>fB', '<cmd>Buffers<CR>')
		-- Mark picker
		-- cmd([[ command! Marks :lua require('modules.navigation.telescope').marks() ]])
		-- ctags picker
		-- cmd([[ command! Ctags :lua require('modules.navigation.telescope').ctags() ]])
		-- Quickfix picker
		-- cmd([[ command! Quickfixes :lua require('modules.navigation.telescope').quickfix() ]])
		-- Location list picker
		-- cmd([[ command! Loclist :lua require('telescope.builtin').loclist() ]])
		-- Registers picker
		cmd([[ command! Registers :lua require('modules.navigation.telescope').registers() ]])
		nmap('<leader>fR', '<cmd>Registers<CR>')
		-- Command picker
		cmd([[ command! Commands :lua require('modules.navigation.telescope').commands() ]])
		-- Command history picker
		cmd([[ command! CommandHistory :lua require('modules.navigation.telescope').command_history() ]])
		-- Help tag picker
		cmd([[ command! Help :lua require('modules.navigation.telescope').help() ]])
		-- Man page picker
		cmd([[ command! ManPages :lua require('modules.navigation.telescope').man_pages() ]])
		-- Colorschemes picker
		-- cmd([[ command! Colorschemes :lua require('telescope.builtin').colorscheme() ]])
		-- Keymaps picker
		-- cmd([[ command! Keymaps :lua require('telescope.builtin').keymaps() ]])
		-- }}}
		-- {{{ Git pickers
		-- Commits picker
		-- cmd([[ command! Commits :lua require('telescope.builtin').git_commits() ]])
		-- Commits picker for this buffer
		-- cmd([[ command! BCommits :lua require('telescope.builtin').git_bcommits() ]])
		-- }}}
		-- {{{ LSP pickers
		-- Goto definition picker
		cmd([[ command! LSPGotoDefinition :lua require('modules.navigation.telescope').lsp.definitions() ]])
		-- Diagnostics pickers
		cmd([[ command! LSPDiagnostics :lua require('modules.navigation.telescope').lsp.diagnostics() ]])
		cmd([[ command! LSPWDiagnostics :lua require('modules.navigation.telescope').lsp.workspace_diagnostics() ]])
		-- References picker
		cmd([[ command! LSPReferences :lua require('modules.navigation.telescope').lsp.references() ]])
		-- Document symbols picker
		cmd([[ command! LSPDSymbols :lua require('modules.navigation.telescope').lsp.document_symbols() ]])
		-- Workspace symbols picker
		cmd([[ command! LSPWSymbols :lua require('modules.navigation.telescope').lsp.workspace_symbols() ]])
		-- Code actions picker
		cmd([[ command! LSPActions :lua require('modules.navigation.telescope').lsp.code_actions() ]])
		-- Range code actions picker
		cmd([[ command! LSPRangeActions :lua require('modules.navigation.telescope').lsp.range_actions() ]])
		-- }}}
	end,
}
-- }}}
-- {{{ nvim-bqf : Better quickfix list
plugins['kevinhwang91/nvim-bqf'] = {}
-- }}}
-- {{{ vim-smoothie : Smooth page-down and page-up
plugins['psliwka/vim-smoothie'] = {}
-- }}}
-- {{{ vim-tmux-focus-events : tmux event compatbility
-- plugins['tmux-plugins/vim-tmux-focus-events'] = {}
-- }}}
-- {{{ alpha-nvim : Dashboard
plugins['goolord/alpha-nvim'] = {
	config = function()
		require('alpha').setup(require('alpha.themes.dashboard').opts)
	end,
}
-- }}}
-- {{{ vim-automkdir : Automatically make nonexistent directories
plugins['benizi/vim-automkdir'] = {}
-- }}}
-- {{{ restore_view.vim : Restore view
plugins['vim-scripts/restore_view.vim'] = {
	config = function()
		vim.o.viewoptions = 'cursor,folds,slash,unix'
	end,
}
-- }}}

return plugins
