-- luacheck: globals vim
local plugins = {}

-- Agda support
plugins['msuperdock/vim-agda'] = {
	config = function()
		-- Initialize keybinds
	end,
}

-- Asciidoctor support
plugins['habamax/vim-asciidoctor'] = {
	ft = { 'asciidoc' },
	config = function()
		-- No coneal
		vim.g.asciidoctor_syntax_conceal = 0
	end,
}

-- luseful csv utilities and highlighting
plugins['mechatroner/rainbow_csv'] = { ft = { 'csv' } }

-- C++ highlighting
-- plugins['bfrg/vim-cpp-modern'] = {}

-- EBNF syntax file
plugins['a-vrma/ebnf-vim'] = {}

-- ebuild support
plugins['gentoo/gentoo-syntax'] = {}

-- editorconfig support
plugins['editorconfig/editorconfig-vim'] = {}

-- ELinks configuration syntax file
plugins['vim-scripts/elinks.vim'] = {}

-- elvish support
plugins['dmix/elvish.vim'] = {}

-- i3 configuration file syntax
plugins['mboughaba/i3config.vim'] = {}

-- LLVM IR support
plugins['rhysd/vim-llvm'] = {}

-- Better lua highlighting
plugins['euclidianAce/BetterLua.vim'] = { ft = { 'lua' } }

-- mbsyncrc highlighting
plugins['chunkhang/vim-mbsync'] = {}

-- NEON filetype support
plugins['Dophin2009/neon-syntax.vim'] = {}

-- Nginx configuration highlighting
plugins['chr4/nginx.vim'] = {}

-- Pandoc support
plugins['vim-pandoc/vim-pandoc'] = {
	requires = { { 'vim-pandoc/vim-pandoc-syntax' } },
	config = function()
		-- Disable certain pandoc modules
		-- vim.g['pandoc#modules#disabled'] = { 'folding', 'spell' }
	end,
}

-- PostgreSQL support
plugins['lifepillar/pgsql.vim'] = { ft = { 'pgsql' } }

-- R Markdown support
plugins['vim-pandoc/vim-rmarkdown'] = {
	after = { 'vim-pandoc' },
	ft = { 'rmarkdown' },
}

-- Reason support
plugins['arrowresearch/vim-reason'] = {}

-- Cargo.toml crate version hints
plugins['mhinz/vim-crates'] = {
	ft = { 'toml' },
	config = function()
		local aug = [[
        aug ftdetect_cargotoml
          autocmd BufRead Cargo.toml call crates#toggle()
        aug end ]]
		vim.api.nvim_exec(aug, true)
	end,
}

-- Good TeX support
plugins['lervag/vimtex'] = {
	config = function()
		local g = vim.g
		g.tex_flavor = 'latex'
		g.vimtex_enabled = 1

		-- Syntax options
		g.vimtex_syntax_enabled = 1
		g.vimtex_syntax_custom_cmds = {
			{ name = 'vert', mathmode = 1, conceal = 1, concealchar = '|' },
			{ name = 'textbf', mathmode = 1, conceal = 1, argstyle = 'bold' },
		}

		-- View options
		g.vimtex_view_method = 'zathura'
	end,
}

-- Vader support
plugins['junegunn/vader.vim'] = {}

return plugins
