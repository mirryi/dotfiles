-- luacheck: globals vim
local plugins = {}

-- Distraction-free writing environment
-- plugins['junegunn/goyo.vim'] = {
-- config = function()
-- require('modules.writing.config').goyo()
-- end,
-- }

-- Find poorly repeated words in writing
-- plugins['dbmrq/vim-ditto'] = {
-- ft = { 'markdown', 'pandoc', 'text', 'tex' },
-- config = function()
-- require('modules.writing.config').ditto()
-- end,
-- }

-- Thesaurus utility
plugins['ron89/thesaurus_query.vim'] = {
	setup = function()
		require('modules.writing.config').thesaurus()
	end,
}

return plugins
