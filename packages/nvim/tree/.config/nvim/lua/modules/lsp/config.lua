-- luacheck: globals vim
local mod = 'modules.lsp'

local config = {}

-- {{{ lspconfig
config.lspconfig = function()
	-- Show diagnostics on hover
	vim.api.nvim_exec(
		[[
    aug lsp_autocmds
      autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
    aug END
    ]],
		true
	)

	require(mod .. '.servers')
end
-- }}}

-- {{{ flutter
config.flutter = function()
	require(mod .. '.servers.flutter')
end
-- }}}

-- {{{ jdtls
config.jdtls = function()
	require(mod .. '.servers.jdtls')
end
-- }}}

-- {{{ metals
config.metals = function()
	require(mod .. '.servers.metals')
end
-- }}}

-- {{{ rust-tools
config.rust_tools = function()
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
					cargo = { loadOutDirsFromCheck = true, allFeatures = true },
					-- checkOnSave = {
					-- allFeatures = true,
					-- overrideCommand = {
					-- 'cargo',
					-- 'clippy',
					-- '--workspace',
					-- '--message-format=json',
					-- '--all-targets',
					-- '--all-features',
					-- },
					-- },
					procMacro = { enable = true },
				},
			},
		},
	})
end
-- }}}

-- {{{ illuminate.vim
config.illuminate = function()
	local bind = require('util.bind')
	bind.nmap('<C-.>', [[ <cmd>lua require('illuminate').next_reference{wrap=true}<CR> ]])
	bind.nmap('<C-,>', [[ <cmd>lua require('illuminate').next_reference{reverse=true, wrap=true}<CR> ]])
end
-- }}}

-- {{{ nvim-lightbulb
config.lightbulb = function()
	vim.cmd([[ autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb() ]])
	vim.fn.sign_define('LightBulbSign', { text = '' })
end
-- }}}

-- {{{ lsp-trouble
config.trouble = function()
	local bind = require('util.bind')
	local trouble = require('trouble')
	trouble.setup({})

	bind.nmap('gL', '<cmd>LspTroubleDocumentOpen<CR>')
	bind.nmap('gwL', '<cmd>LspTroubleWorkspaceOpen<CR>')
end
-- }}}

-- {{{ nvim-lint
config.lint = function()
	local lint = require('lint')

	local use = function(t)
		local function register(names)
			if type(names) == 'table' then
				for _, name in ipairs(names) do
					register(name)
				end
			else
				local ok, linter = pcall(require, mod .. '.lint.' .. names)
				if ok then
					rawset(lint.linters, names, linter)
				end
			end
		end

		for _, linters in pairs(t) do
			register(linters)
		end

		lint.linters_by_ft = t
	end

	-- Register linters and autocmd
	vim.api.nvim_command([[aug Lint]])
	vim.api.nvim_command([[au BufReadPost,TextChanged,TextChangedI <buffer> lua require('lint').try_lint()]])
	vim.api.nvim_command([[aug END]])

	-- Define linters
	use({
		cpp = { 'cppcheck' },
		lua = { 'luacheck' },
		-- pandoc = {'vale'},
		sh = { 'shellcheck' },
		tex = { 'chktex' },
	})
end
-- }}}

-- {{{ nvim-treesitter
config.treesitter = function()
	local treesitter = require('nvim-treesitter.configs')
	if treesitter ~= nil then
		treesitter.setup({
			ensure_installed = 'maintained',
			highlight = {
				enable = true,
				disable = { 'cmake', 'latex', 'ocaml', 'r', 'rust', 'scss', 'tex', 'toml', 'yaml' },
			},
			indent = { enable = true, disable = { 'lua', 'rust', 'tex' } },
			refactor = {
				enable = true,
				disable = { 'tex' },
				highlight_definitions = { enable = true },
				highlight_current_scope = { enable = false },
				keymaps = { goto_definition = 'gd' },
			},
			-- External modules
			autotag = { enable = true, disable = { 'tex' } },
			context_commentstring = { enable = true },
			rainbow = {
				enable = true,
				disable = { 'tex' },
				extended_mode = true,
			},
		})
	end
end
-- }}}

return config
