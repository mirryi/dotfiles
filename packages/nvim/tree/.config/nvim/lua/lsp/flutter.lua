local flutter_tools = require('flutter-tools')

local handlers = require('lsp/handlers')
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities

flutter_tools.setup({
	lsp = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
})
