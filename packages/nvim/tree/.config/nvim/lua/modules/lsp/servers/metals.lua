-- luacheck: globals vim
local metals = require('metals')

local handlers = require('modules.lsp.handlers')
local metals_capabilities = vim.deepcopy(handlers.capabilities)
metals_capabilities.offsetEncoding = { 'utf-8' }

local metals_config = metals.bare_config()
metals_config.on_attach = handlers.on_attach
metals_config.capabilities = metals_capabilities
metals_config.settings = {
    useGlobalExecutable = true,
    showImplicitArguments = true,
    showInferredType = true,
    superMethodLensesEnabled = true,
    showImplicitConversionsAndClasses = true,
}

local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'scala', 'sbt', 'java' },
    callback = function()
        metals.initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})
