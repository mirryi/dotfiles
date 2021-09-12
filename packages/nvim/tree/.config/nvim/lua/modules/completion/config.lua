-- luacheck: globals vim
local config = {}

local sources = function()
	local sources = {
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
		{ name = 'path' },
		-- { name = 'buffer' },
	}

	local ft = vim.o.ft
	if ft == 'lua' then
		table.insert(sources, { name = 'nvim_lua' })
	end
	if ft == 'markdown' or ft == 'pandoc' or ft == 'tex' then
		table.insert(sources, { name = 'spell' })
	end
	return sources
end

local mapping = function()
	local cmp = require('cmp')

	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

	local check_back_space = function()
		local col = vim.fn.col('.') - 1
		return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
	end

	local tab_complete = function(fallback)
		if vim.fn.pumvisible() == 1 then
			vim.fn.feedkeys(t('<C-n>'), 'n')
		elseif vim.fn['UltiSnips#CanExpandSnippet']() == 1 or vim.fn['UltiSnips#CanJumpForwards']() == 1 then
			vim.fn.feedkeys(t('<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>'), '')
		elseif check_back_space() then
			vim.fn.feedkeys(t('<Tab>'), 'n')
		else
			fallback()
		end
	end

	local s_tab_complete = function(fallback)
		if vim.fn.pumvisible() == 1 then
			vim.fn.feedkeys(t('<C-p>'), 'n')
		elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
			vim.fn.feedkeys(t('<C-R>=UltiSnips#JumpBackwards()<CR>'), '')
		else
			fallback()
		end
	end

	return {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		['<Tab>'] = cmp.mapping(tab_complete, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(s_tab_complete, { 'i', 's' }),
	}
end

config.nvim_cmp = function()
	local cmp = require('cmp')

	cmp.setup({
		sources = sources(),
		mapping = mapping(),
		autocomplete = true,
		preselect = false,
		snippet = {
			expand = function(args)
				vim.fn['UltiSnips#Anon'](args.body)
			end,
		},
		completion = {
			autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
			completeopt = 'menu,menuone,noselect',
		},
	})
end

config.autopairs = function()
	local autopairs = require('nvim-autopairs')
	autopairs.setup({
		disable_filetype = { 'TelescopePrompt' },
		ignored_next_char = '[%w%.]',
		enable_check_bracket_line = false,
		fast_wrap = {
			map = '<C-e>',
		},
	})

	local autopairs_cmp = require('nvim-autopairs.completion.cmp')
	autopairs_cmp.setup({
		map_cr = false,
		map_complete = false,
		auto_select = true,
	})
end

return config
