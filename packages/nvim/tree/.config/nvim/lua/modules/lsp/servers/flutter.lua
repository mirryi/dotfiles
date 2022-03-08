local flutter_tools = require('flutter-tools')

local handlers = require('modules.lsp.handlers')

flutter_tools.setup {
    lsp = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    },
}
