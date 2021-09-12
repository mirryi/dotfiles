-- luacheck: globals vim
local jdtls = require('jdtls')

local handlers = require('modules.lsp.handlers')

jdtls.start_or_attach({
	cmd = { vim.g.nvim_config .. '/lua/modules/lsp/servers/jdtls.sh' },
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
})
