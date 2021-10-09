-- luacheck: globals vim
local lspconfig = require('lspconfig')
-- local configs = require('lspconfig.configs')

-- override handlers
local handlers = require('modules.lsp.handlers')
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities

-- bash language server
lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })

-- clangd
-- local clangd_handlers = nil
lspconfig.clangd.setup({
	-- handlers = clangd_handlers,
	on_attach = on_attach,
	capabilities = capabilities,
})

-- cmake language server
lspconfig.cmake.setup({ on_attach = on_attach, capabilities = capabilities })

-- css language server
lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })

-- deno language server
-- lspconfig.denols.setup {
-- init_options = {lint = true},
-- on_attach = on_attach,
-- capabilities = capabilities
-- }

-- dhall language server
lspconfig.dhall_lsp_server.setup({ on_attach = on_attach, capabilities = capabilities })

-- dockerfile language server
lspconfig.dockerls.setup({ on_attach = on_attach, capabilities = capabilities })

-- go language server
lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })

-- haskell ide engine
lspconfig.hie.setup({ on_attach = on_attach, capabilities = capabilities })

-- html language server
lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })

-- java language server
-- lspconfig.jdtls.setup {
-- on_attach = on_attach,
-- capabilities = capabilities,
-- root_dir = lspconfig.util.root_pattern('.project')
-- }

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

-- rust analyzer
-- lspconfig.rust_analyzer.setup({
-- on_attach = on_attach,
-- capabilities = capabilities,
-- settings = {
-- ['rust-analyzer'] = {
-- assist = { importGranularity = 'module' },
-- cargo = { loadOutDirsFromCheck = true, allFeatures = true },
-- -- checkOnSave = {
-- -- allFeatures = true,
-- -- overrideCommand = {
-- -- 'cargo', 'clippy', '--workspace', '--message-format=json',
-- -- '--all-targets', '--all-features'
-- -- }
-- -- },
-- procMacro = { enable = true },
-- },
-- },
-- })

-- taplo
-- if not configs.taplo_lsp then
-- configs.taplo_lsp = {
-- default_config = {
-- cmd = {'taplo-lsp', 'run'},
-- filetypes = {'toml'},
-- root_dir = function(fname)
-- return lspconfig.util.root_pattern('taplo.toml')(fname) or
-- lspconfig.util.find_git_ancestor(fname) or
-- vim.fn.getcwd()
-- end
-- }
-- }
-- end
-- lspconfig.taplo_lsp.setup {on_attach = on_attach, capabilities = capabilities}

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
-- local autopep8 = require('modules.lsp.efm.autopep8')
local eslint = require('modules.lsp.efm.eslint')
-- local fixjson = require('modules.lsp.efm.fixjson')
-- local flake8 = require('modules.lsp.efm.flake8')
local goimports = require('modules.lsp.efm.goimports')
local golint = require('modules.lsp.efm.golint')
local htmlhint = require('modules.lsp.efm.htmlhint')
-- local ktlint = require('modules.lsp.efm.ktlint')
-- local lacheck = require('modules.lsp.efm.lacheck')
-- local luacheck = require('modules.lsp.efm.luacheck')
-- local luafmt = require('modules.lsp.efm.luafmt')
-- local luac = require('modules.lsp.efm.luac')
-- local misspell = require('modules.lsp.efm.misspell')
-- local mypy = require('modules.lsp.efm.mypy')
local pandoc = require('modules.lsp.efm.pandoc')
-- local psalm = require('modules.lsp.efm.psalm')
local phpcs = require('modules.lsp.efm.phpcs')
local phpstan = require('modules.lsp.efm.phpstan')
local prettier = require('modules.lsp.efm.prettier')
-- local reorder_python_imports = require('modules.lsp.efm.reorder_python_imports')
local shfmt = require('modules.lsp.efm.shfmt')
local stylua = require('modules.lsp.efm.stylua')
local stylelint = require('modules.lsp.efm.stylelint')
local taplo = require('modules.lsp.efm.taplo')
local tidy = require('modules.lsp.efm.tidy')
-- local vale = require('modules.lsp.efm.vale')
-- local vint = require('modules.lsp.efm.vint')
-- local xmllint = require('modules.lsp.efm.xmllint')
-- local yamllint = require('modules.lsp.efm.yamllint')

lspconfig.efm.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = { documentformatting = true },
	filetypes = {
		'bash',
		'css',
		'go',
		'html',
		'javascript',
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		-- 'json',
		'lua',
		'pandoc',
		'php',
		'sass',
		'scss',
		'sh',
		'toml',
		'typescript',
		'typescriptreact',
		'typescript.tsx',
		'vim',
		'zsh',
	},
	settings = {
		cmd = { 'efm-langserver' },
		rootmarkers = { '.git/' },
		languages = {
			-- ["="] = {misspell},
			bash = { shfmt },
			css = { stylelint },
			go = { golint, goimports },
			html = { htmlhint, prettier },
			javascript = { eslint, prettier },
			javascriptreact = { eslint, prettier },
			['javascript.jsx'] = { eslint, prettier },
			-- json = { fixjson, prettier },
			-- kotlin = {ktlint},
			-- latex = {lacheck},
			lua = { stylua },
			pandoc = {
				pandoc,
				--vale
			},
			php = {
				prettier, -- psalm,
				phpstan,
				phpcs,
			},
			sass = { prettier, stylelint },
			scss = { prettier, stylelint },
			sh = { shfmt },
			toml = { taplo },
			typescript = { eslint, prettier },
			typescriptreact = { eslint, prettier },
			['typescript.tsx'] = { eslint, prettier },
			xml = {
				-- xmllint,
				tidy,
			},
			-- yaml = {yamllint},
			zsh = { shfmt },
		},
	},
})
