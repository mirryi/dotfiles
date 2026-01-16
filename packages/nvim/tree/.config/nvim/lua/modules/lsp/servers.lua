-- luacheck: globals vim
local lspconfig = require('lspconfig')
local schemastore = require('schemastore')

-- override handlers
local handlers = require('modules.lsp.handlers')
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities

local servers = {}

-- ansible language server
servers['ansiblels'] = { on_attach = on_attach, capabilities = capabilities }

-- bash language server
servers['bashls'] = { on_attach = on_attach, capabilities = capabilities }

-- biome language server
servers['biome'] = { on_attach = on_attach, capabilities = capabilities }

-- clangd
local clangd_capabilities = vim.deepcopy(capabilities)
clangd_capabilities.offsetEncoding = { 'utf-16' }
servers['clangd'] = { on_attach = on_attach, capabilities = clangd_capabilities }

-- cmake language server
servers['cmake'] = { on_attach = on_attach, capabilities = capabilities }

-- css language server
-- servers['cssls'] = { on_attach = on_attach, capabilities = capabilities }

-- dafny language server
servers['dafny'] = { on_attach = on_attach, capabilities = capabilities }

-- dhall language server
servers['dhall_lsp_server'] = { on_attach = on_attach, capabilities = capabilities }

-- dockerfile language server
servers['dockerls'] = { on_attach = on_attach, capabilities = capabilities }

-- dot language server
servers['dotls'] = { on_attach = on_attach, capabilities = capabilities }

-- eslint language server
servers['eslint'] = { on_attach = on_attach, capabilities = capabilities }

-- go language server
servers['gopls'] = { on_attach = on_attach, capabilities = capabilities }

-- haskell language server
servers['hls'] = { on_attach = on_attach, capabilities = capabilities }

-- html language server
servers['html'] = { on_attach = on_attach, capabilities = capabilities }

-- json language server
local jsonls_capabilities = vim.deepcopy(capabilities)
jsonls_capabilities.textDocument.completion.completionItem.snippetSupport = true
servers['jsonls'] = {
    on_attach = on_attach,
    capabilities = jsonls_capabilities,
    settings = {
        schemas = schemastore.json.schemas(),
    },
}

-- julia language server
servers['julials'] = { on_attach = on_attach, capabilities = capabilities }

-- kotlin language server
servers['kotlin_language_server'] = { on_attach = on_attach, capabilities = capabilities }

-- lua language server
servers['lua_ls'] = {
    cmd = { 'lua-language-server' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { enable = false },
            format = { enable = false },
            workspace = { maxPreload = 9999, checkThirdParty = false },
        },
    },
}

-- nickel language server
servers['nickel_ls'] = { on_attach = on_attach, capabilities = capabilities }

-- ocaml/reason language server
servers['ocamllsp'] = { on_attach = on_attach, capabilities = capabilities }

-- oxc language server
servers['oxlint'] = { on_attach = on_attach, capabilities = capabilities }

-- perl language server
servers['perlls'] = { on_attach = on_attach, capabilities = capabilities }

-- php language server
servers['intelephense'] = {
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
}

-- php language server
-- servers['phpactor'] = {on_attach = on_attach, capabilities = capabilities}

-- python language server
servers['pylsp'] = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'python', 'sage' },
}

-- pyright language server
servers['pyright'] = { on_attach = on_attach, capabilities = capabilities }

-- r language server
servers['r_language_server'] = { on_attach = on_attach, capabilities = capabilities }

-- solargraph (ruby)
servers['solargraph'] = { on_attach = on_attach, capabilities = capabilities }

-- taplo (toml)
servers['taplo'] = { on_attach = on_attach, capabilities = capabilities }

-- tailwindcss
-- servers['tailwindcss'] = { on_attach = on_attach, capabilities = capabilities }

-- terraform
servers['terraformls'] = { on_attach = on_attach, capabilities = capabilities }

-- texlab
servers['texlab'] = { on_attach = on_attach, capabilities = capabilities }

-- typescript
servers['ts_ls'] = {
    on_attach = function(client, bufnr)
        -- Enable incremental sync
        if client.config.flags then
            client.config.flags.allow_incremental_sync = true
        end

        local ts_utils = require('nvim-lsp-ts-utils')
        vim.lsp.handlers['textDocument/codeAction'] = ts_utils.code_action_handler
        ts_utils.setup { enable_import_on_completion = true }

        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gS', ':TSLspOrganize<CR>', { silent = true })
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gQ', ':TSLspFixCurrent<CR>', { silent = true })
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gT', ':TSLspRenameFile<CR>', { silent = true })
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', { silent = true })

        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
}

-- typst language server
servers['tinymist'] = { on_attach = on_attach, capabilities = capabilities }

-- vim language server
servers['vimls'] = { on_attach = on_attach, capabilities = capabilities }

-- Non-lsp linter/formatter integration
local nullls = require('null-ls')
local builtins = nullls.builtins
nullls.setup {
    diagnostics_format = '#{m} (#{s})',
    sources = {
        -- generic
        -- builtins.formatting.trim_newlines,
        -- builtins.formatting.trim_whitespace,
        -- builtins.diagnostics.trail_space,

        -- c / c++
        builtins.diagnostics.cppcheck.with {
            filetypes = { 'c' },
            method = nullls.methods.DIAGNOSTICS_ON_SAVE,
            extra_args = { '--inline-suppr' },
        },
        -- builtins.diagnostics.cppcheck.with({
        -- filetypes = { 'cpp' },
        -- method = nullls.methods.DIAGNOSTICS_ON_SAVE,
        -- extra_args = { '--inline-suppr', '--language=c++' },
        -- }),
        builtins.formatting.cmake_format,

        -- docker
        builtins.diagnostics.hadolint.with {
            method = nullls.methods.DIAGNOSTICS_ON_SAVE,
        },

        -- go
        builtins.formatting.goimports,

        -- javascript / typescript / etc.
        -- builtins.formatting.prettierd,
        -- builtins.formatting.rustywind,
        -- builtins.diagnostics.stylelint,
        -- builtins.formatting.stylelint,

        -- latex
        -- builtins.diagnostics.chktex,

        -- lua
        -- builtins.diagnostics.luacheck,
        builtins.formatting.stylua.with {
            cwd = function(_)
                local bufpath = vim.api.nvim_buf_get_name(0)
                return lspconfig.util.root_pattern('stylua.toml')(bufpath)
            end,
        },
        builtins.diagnostics.selene.with {
            cwd = function(_)
                local bufpath = vim.api.nvim_buf_get_name(0)
                return lspconfig.util.root_pattern('selene.toml')(bufpath)
            end,
        },

        -- php
        builtins.diagnostics.phpstan,
        builtins.diagnostics.phpcs,

        -- python
        -- builtins.formatting.isort,
        -- builtins.formatting.yapf,
        -- builtins.diagnostics.flake8,
        -- builtins.formatting.autopep8,

        -- shell
        -- builtins.formatting.shfmt,
        -- builtins.formatting.shellharden,

        -- vimscript
        builtins.diagnostics.vint,

        -- yaml
        -- builtins.diagnostics.yamllint,
    },
}

return servers
