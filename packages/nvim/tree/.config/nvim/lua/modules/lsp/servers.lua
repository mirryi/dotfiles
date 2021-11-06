-- luacheck: globals vim
local lspconfig = require('lspconfig')

-- override handlers
local handlers = require('modules.lsp.handlers')
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities

-- agda language server
lspconfig.als.setup({ on_attach = on_attach, capabilities = capabilities })

-- bash language server
lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })

-- clangd
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- cmake language server
lspconfig.cmake.setup({ on_attach = on_attach, capabilities = capabilities })

-- css language server
lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })

-- dhall language server
lspconfig.dhall_lsp_server.setup({ on_attach = on_attach, capabilities = capabilities })

-- dockerfile language server
lspconfig.dockerls.setup({ on_attach = on_attach, capabilities = capabilities })

-- dot language server
lspconfig.dotls.setup({ on_attach = on_attach, capabilities = capabilities })

-- eslint language server
lspconfig.eslint.setup({ on_attach = on_attach, capabilities = capabilities })

-- go language server
lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })

-- haskell ide engine
lspconfig.hie.setup({ on_attach = on_attach, capabilities = capabilities })

-- html language server
lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })

-- jedi language server
-- lspconfig.jedi_language_server.setup {
-- on_attach = on_attach,
-- capabilities = capabilities
-- }

-- json language server
lspconfig.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })

-- kotlin language server
lspconfig.kotlin_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- lua language server
lspconfig.sumneko_lua.setup({
	cmd = { 'lua-language-server' },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = { diagnostics = { enable = false }, workspace = { maxPreload = 2000 } },
	},
})

-- ocaml/reason language server
lspconfig.ocamllsp.setup({ on_attach = on_attach, capabilities = capabilities })

-- php language server
lspconfig.intelephense.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
})

-- php language server
-- lspconfig.phpactor.setup {on_attach = on_attach, capabilities = capabilities}

-- php psalm language server
-- if not configs.psalm_lsp then
-- configs.psalm_lsp = {
-- default_config = {
-- cmd = {'vendor/bin/psalm-language-server'},
-- filetypes = {'php'},
-- root_dir = function(fname)
-- -- return lspconfig.util.find_git_ancestor(fname)
-- return lspconfig.util.root_pattern('composer.json', '.git')(
-- fname) or lspconfig.util.find_git_ancestor(fname)
-- end,
-- settings = {}
-- }
-- }
-- end
-- lspconfig.psalm_lsp.setup {on_attach = on_attach, capabilities = capabilities}

-- python language server
lspconfig.pylsp.setup({ on_attach = on_attach, capabilities = capabilities })

-- pyright language server
-- lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })

-- r language server
lspconfig.r_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- taplo (toml)
lspconfig.taplo.setup({ on_attach = on_attach, capabilities = capabilities })

-- tailwindcss
lspconfig.tailwindcss.setup({ on_attach = on_attach, capabilities = capabilities })

-- texlab
lspconfig.texlab.setup({ on_attach = on_attach, capabilities = capabilities })

-- tsserver
lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		-- Enable incremental sync
		if client.config.flags then
			client.config.flags.allow_incremental_sync = true
		end

		-- Disable built-in formatting
		client.resolved_capabilities.document_formatting = false

		local ts_utils = require('nvim-lsp-ts-utils')
		vim.lsp.handlers['textDocument/codeAction'] = ts_utils.code_action_handler
		ts_utils.setup({ enable_import_on_completion = true })

		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gS', ':TSLspOrganize<CR>', { silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gQ', ':TSLspFixCurrent<CR>', { silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gT', ':TSLspRenameFile<CR>', { silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', { silent = true })

		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
})

-- vim language server
lspconfig.vimls.setup({ on_attach = on_attach, capabilities = capabilities })

-- yaml language server
-- lspconfig.yamlls.setup {on_attach = on_attach, capabilities = capabilities}

-- efm-langserver
local pandoc = require('modules.lsp.efm.pandoc')
local tidy = require('modules.lsp.efm.tidy')

lspconfig.efm.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = { documentformatting = true },
	filetypes = {
		'pandoc',
		'xml',
	},
	settings = {
		cmd = { 'efm-langserver' },
		rootmarkers = { '.git/' },
		languages = {
			pandoc = {
				pandoc,
			},
			xml = {
				tidy,
			},
		},
	},
})

-- Non-lsp linter/formatter integration
local nullls = require('null-ls')
local builtins = nullls.builtins
nullls.config({
	diagnostics_format = '#{m} (#{s})',
	sources = {
		-- generic
		builtins.formatting.trim_newlines,
		builtins.formatting.trim_whiespace,

		-- c / c++
		-- builtins.diagnostics.cppcheck.with({
		-- extra_args = { '--project=compile_commands.json', '--cppcheck-build-dir=.cache/cppcheck' },
		-- }),
		builtins.formatting.clang_format,
		builtins.formatting.cmake_format,

		-- docker
		builtins.diagnostics.hadolint,

		-- go
		builtins.formatting.goimports,

		-- json
		builtins.formatting.fixjson,

		-- javascript / typescript / etc.
		builtins.formatting.prettierd,
		builtins.formatting.rustywind,
		builtins.diagnostics.stylelint,
		builtins.formatting.stylelint,

		-- latex
		-- builtins.diagnostics.chktex,

		-- lua
		builtins.diagnostics.luacheck,
		builtins.formatting.stylua,
		-- builtins.diagnostics.selene,

		-- php
		builtins.diagnostics.phpstan,
		builtins.diagnostics.psalm,
		builtins.diagnostics.phpcs,

		-- python
		builtins.formatting.isort,
		-- builtins.diagnostics.flake8,
		-- builtins.formatting.autopep8,

		-- shell
		builtins.diagnostics.shellcheck,
		builtins.formatting.shfmt,
		builtins.formatting.shellharden,

		-- vimscript
		builtins.diagnostics.vint,

		-- yaml
		builtins.diagnostics.yamllint,
	},
})
lspconfig['null-ls'].setup({ on_attach = on_attach, capabilities = capabilities })
