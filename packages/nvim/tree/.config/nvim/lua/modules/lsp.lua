-- luacheck: globals vim
local plugins = {}

-- {{{ nvim-lightbulb : Code action indicator
plugins['kosayoda/nvim-lightbulb'] = {
	config = function()
		vim.cmd([[ autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb() ]])
		vim.fn.sign_define('LightBulbSign', { text = '' })
	end,
}
-- }}}
-- {{{ vim-illuminate : Highlight same item instances
plugins['RRethy/vim-illuminate'] = {
	config = function()
		local bind = require('util.bind')
		bind.nmap('<C-.>', [[ <cmd>lua require('illuminate').next_reference{wrap=true}<CR> ]])
		bind.nmap('<C-,>', [[ <cmd>lua require('illuminate').next_reference{reverse=true, wrap=true}<CR> ]])
	end,
}
-- }}}
-- {{{ lsp-trouble.nvim : Pretty diagnostics view list
plugins['folke/lsp-trouble.nvim'] = {
	requires = {
		{ 'kyazdani42/nvim-web-devicons' },
	},
	config = function()
		local trouble = require('trouble')
		trouble.setup({})

		local bind = require('util.bind')
		bind.nmap('gL', '<cmd>LspTroubleDocumentOpen<CR>')
		bind.nmap('gwL', '<cmd>LspTroubleWorkspaceOpen<CR>')
	end,
}
-- }}}
-- {{{
-- plugins['j-hui/fidget.nvim'] = {
-- config = function()
-- require('fidget').setup()
-- end,
-- }
-- }}}
-- {{{ nvim-treesitter : Treesitter support
plugins['nvim-treesitter/nvim-treesitter'] = {
	requires = {
		'nvim-treesitter/nvim-treesitter-refactor',
		-- Auto close HTML/XML tags
		'windwp/nvim-ts-autotag',
		-- Treesitter-based commentstring
		-- 'JoosepAlviste/nvim-ts-context-commentstring'
		{
			'romgrk/nvim-treesitter-context',
			config = function()
				require('treesitter-context').setup({ enable = true, throttle = true })
			end,
		},
		'haringsrob/nvim_context_vt',
		-- Spellcheck using treesitter
		{
			'lewis6991/spellsitter.nvim',
			after = { 'nvim-treesitter' },
			config = function()
				require('spellsitter').setup()
			end,
		},
		-- Rainbow parentheses
		'p00f/nvim-ts-rainbow',
		{
			'luochen1990/rainbow',
			ft = { 'latex', 'ocaml', 'reason', 'rust', 'tex' },
			setup = function()
				vim.g.rainbow_active = 1
			end,
		},
		-- Swapping of parameters, lists, arrays, etc.
		{
			'mizlan/iswap.nvim',
			config = function()
				require('iswap').setup({})
			end,
		},
	},
	config = function()
		local treesitter = require('nvim-treesitter.configs')
		local highlight_disabled = { 'cmake', 'latex', 'make', 'ocaml', 'r', 'rust', 'scss', 'tex', 'toml', 'yaml' }
		treesitter.setup({
			ensure_installed = 'maintained',
			highlight = {
				enable = true,
				disable = highlight_disabled,
			},
			indent = { enable = true },
			refactor = {
				enable = true,
				highlight_definitions = { enable = true },
				highlight_current_scope = { enable = false },
				keymaps = { goto_definition = 'gd' },
			},
			-- External modules
			autotag = { enable = true },
			context_commentstring = { enable = true },
			rainbow = {
				enable = true,
				disable = highlight_disabled,
				extended_mode = true,
			},
		})
	end,
}
-- }}}
-- {{{ nvim-lspconfig : Predefined language server configurations
plugins['neovim/nvim-lspconfig'] = {
	requires = {
		-- Non-lsp linter integration
		{ 'jose-elias-alvarez/null-ls.nvim' },
		-- Support for tsserver extensions
		{ 'jose-elias-alvarez/nvim-lsp-ts-utils' },
		-- Rust inline type indications
		{ 'nvim-lua/lsp_extensions.nvim', ft = { 'rust' } },
		-- Better UIs
		{ 'RishabhRD/nvim-lsputils', requires = { { 'RishabhRD/popfix' } } },
		-- Better code actions menus
		-- { 'weilbith/nvim-code-action-menu' },
	},
	config = function()
		-- Show diagnostics on hover
		vim.api.nvim_exec(
			[[ aug lsp_autocmds autocmd CursorHold * lua vim.diagnostic.open_float({focus = false}) aug END ]],
			true
		)

		require('modules.lsp.servers')
	end,
}
-- }}}
-- {{{ nvim-dap : Debugging support
plugins['mfussenegger/nvim-dap'] = {
	requires = { { 'rcarriga/nvim-dap-ui' }, { 'theHamsta/nvim-dap-virtual-text' } },
	config = function()
		require('modules.lsp.dap')
	end,
}
-- }}}
-- {{{ nvim-jdtls : Enhanced java language server
plugins['mfussenegger/nvim-jdtls'] = {
	ft = { 'java' },
	config = function()
		require('modules.lsp.servers.jdtls')
	end,
}
-- }}}
-- {{{ nvim-metals : Enhanced scala language server and tools
plugins['scalameta/nvim-metals'] = {
	ft = { 'scala', 'sbt' },
	config = function()
		require('modules.lsp.servers.metals')
	end,
}
-- }}}
-- {{{ flutter-tools.nvim : Enhanced flutter language server and tools
plugins['akinsho/flutter-tools.nvim'] = {
	requires = { { 'nvim-lua/plenary.nvim' } },
	config = function()
		require('modules.lsp.servers.flutter')
	end,
}
-- }}}
-- rust-tools.nvim : Enahcned rust language server and tools
plugins['simrat39/rust-tools.nvim'] = {
	requires = {
		{ 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
	},
	after = { 'nvim-lspconfig' },
	config = function()
		local rust_tools = require('rust-tools')

		local handlers = require('modules.lsp.handlers')
		local on_attach = handlers.on_attach
		local capabilities = handlers.capabilities

		rust_tools.setup({
			tools = {
				autoSetHints = true,
				runnables = { use_telescope = true },
				inlay_hints = {
					only_current_line = false,
					show_parameter_hints = true,
					max_len_align = false,
				},
				crate_graph = { output = nil, full = true },
			},
			server = {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					['rust-analyzer'] = {
						assist = { importGranularity = 'module' },
						cargo = { loadOutDirsFromCheck = true },
						checkOnSave = {
							allFeatures = true,
							overrideCommand = {
								'cargo',
								'clippy',
								'--message-format=json',
								'--all-targets',
								'--all-features',
							},
						},
						procMacro = { enable = true },
					},
				},
			},
		})
	end,
}
-- }}}

return plugins
