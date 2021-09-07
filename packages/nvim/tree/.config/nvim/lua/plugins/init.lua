-- luacheck: globals vim use
local g = vim.g
local cmd, fn = vim.cmd, vim.fn
local co = require("util.co")

local M = {}

M.status = {}

M.init = function()
	-- Load netrw settings
	require("plugins.netrw")

	local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		local execute = vim.api.nvim_command
		execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
		execute("packadd packer.nvim")
	end
	cmd([[packadd packer.nvim]])

	local packer = require("packer")
	packer.startup(function()
		-- local luse = use
		local luse = function(spec)
			local get_name = function(full)
				local i = 0
				for v in string.gmatch(full, "[^/]+") do
					if i == 0 then
						i = i + 1
					else
						return v
					end
				end
			end

			local name
			if type(spec) == "table" then
				name = get_name(spec[1])

				if spec.config ~= nil then
					local bytecode = string.dump(spec.config, true)
					local exec_string = 'assert(loadstring("' .. bytecode .. '"))(); '
					spec.config = exec_string
				else
					spec.config = ""
				end
			else
				name = get_name(spec)
				spec = { spec, config = "" }
			end

			M.status[name] = false
			spec.config = spec.config .. 'require"plugins".status["' .. name .. '"] = true'

			use(spec)
		end

		luse({ "wbthomason/packer.nvim", opt = true })

		-- Better startup profiling
		-- luse {'tweekmonster/startuptime.vim'}

		-- CurserHold performance fix
		luse({ "antoinemadec/FixCursorHold.nvim" })

		--
		-- STATUSLINE
		--

		-- Lualine statusline
		luse({
			"hoob3rt/lualine.nvim",
			requires = { { "kyazdani42/nvim-web-devicons" } },
		})

		-- Git signs in the signcolumn
		luse({
			"lewis6991/gitsigns.nvim",
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("plugins.gitsigns")
			end,
		})

		--
		-- LSP
		--

		-- More code actions, inlay hints, etc.
		luse({
			"nvim-lua/lsp_extensions.nvim",
			ft = { "rust" },
			config = function()
				require("lsp/lsp_extensions")
			end,
		})

		-- Support for tsserver extensions
		luse({ "jose-elias-alvarez/nvim-lsp-ts-utils" })

		-- Intelligent cursor word highlighting
		-- luse {
		-- 'RRethy/vim-illuminate',
		-- config = function() require 'plugins.illuminate' end
		-- }

		-- Snippets
		-- luse {
		-- 'norcalli/snippets.nvim',
		-- config = function() require 'plugins.snippets' end
		-- }

		-- Completion integration
		-- luse {
		-- 'windwp/nvim-autopairs',
		-- config = function() require 'plugins.autopairs' end
		-- }
		luse({
			"cohama/lexima.vim",
			setup = function()
				require("plugins.lexima.setup")
			end,
			config = function()
				require("plugins.lexima.config")
			end,
		})
		luse({
			"hrsh7th/nvim-compe",
			requires = { { "ray-x/lsp_signature.nvim" } },
			after = {
				-- 'nvim-autopairs'
				"lexima.vim",
			},
			config = function()
				require("lsp/completion")
			end,
		})

		luse({
			"SirVer/ultisnips",
			config = function()
				require("plugins.ultisnips")
			end,
		})

		-- Predefined language server configurations
		luse({
			"neovim/nvim-lspconfig",
			after = {
				"nvim-compe",
				"telescope.nvim", -- 'vim-illuminate',
				"nvim-lsp-ts-utils",
			},
			config = function()
				require("lsp")
			end,
		})

		-- Jdtls for Java
		luse({
			"mfussenegger/nvim-jdtls",
			ft = { "java" },
			after = { "nvim-lspconfig" },
			config = function()
				require("lsp/jdtls")
			end,
		})

		-- Scala support with metals
		luse({
			"scalameta/nvim-metals",
			ft = { "scala", "sbt" },
			config = function()
				require("lsp/metals")
			end,
		})

		-- Flutter suport
		luse({
			"akinsho/flutter-tools.nvim",
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("lsp/flutter")
			end,
		})

		-- Code actions inidicator
		-- luse {
		-- 'kosayoda/nvim-lightbulb',
		-- config = function() require 'plugins.lightbulb' end
		-- }

		-- Pretty diagnostics view list
		luse({
			"folke/lsp-trouble.nvim",
			requires = { { "kyazdani42/nvim-web-devicons" } },
			config = function()
				require("plugins.trouble")
			end,
		})

		-- Linter integration
		luse({
			"mfussenegger/nvim-lint",
			config = function()
				require("plugins.lint")
			end,
		})

		--
		-- EDITING
		--

		-- Better treesitter support
		luse({
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"nvim-treesitter/nvim-treesitter-refactor",
				"windwp/nvim-ts-autotag",
				-- 'JoosepAlviste/nvim-ts-context-commentstring'
			},
			config = function()
				require("plugins.treesitter")
			end,
		})
		-- luse {'romgrk/nvim-treesitter-context', after = {'nvim-treesitter'}}
		-- luse {'haringsrob/nvim_context_vt', after = {'nvim-treesitter'}}

		-- Preview search and replace
		luse({ "markonm/traces.vim" })

		-- Comment and uncomment with keybindings (<leader>c<space>)
		luse({
			"scrooloose/nerdcommenter",
			config = function()
				require("plugins.nerdcommenter")
			end,
		})

		-- Automated text table spacing
		luse({
			"godlygeek/tabular",
			ft = { "asciidoc", "markdown", "pandoc", "rmarkdown", "text", "tex" },
		})

		-- Easy text alignment
		luse({
			"junegunn/vim-easy-align",
			config = function()
				require("plugins.easy-align")
			end,
		})

		-- RGB, hex color highlighting
		luse({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("plugins.colorizer")
			end,
		})

		-- Markdown preview
		luse({
			"npxbr/glow.nvim",
			ft = { "markdown", "pandoc" },
			config = function()
				require("plugins.glow")
			end,
		})

		-- Indent guides
		luse({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("plugins.indentguide")
			end,
		})

		-- Toggle between short/long constructs
		-- luse {
		-- 'AndrewRadev/splitjoin.vim',
		-- config = function() require 'plugins.splitjoin' end
		-- }

		--
		-- NAVIGATION
		--

		-- Jump to two char location
		-- luse {'justinmk/vim-sneak'}

		-- Jump locations
		luse({
			"phaazon/hop.nvim",
			config = function()
				require("plugins.hop")
			end,
		})

		-- Tag management
		luse({
			"ludovicchabant/vim-gutentags",
			config = function()
				require("plugins.gutentags")
			end,
		})

		-- Fuzzy picker
		luse({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
			after = { "nvim-treesitter" },
			config = function()
				require("plugins.telescope")
			end,
		})

		-- Compiled style sorter for telescope.nvim
		luse({
			"nvim-telescope/telescope-fzy-native.nvim",
			after = { "telescope.nvim" },
			config = function()
				require("plugins.telescope-fzy-native")
			end,
		})

		-- Zoxide for telescope.nvim
		-- luse {
		-- 'jvgrootveld/telescope-zoxide',
		-- after = {'telescope.nvim'},
		-- config = function() require 'plugins.telescope-zoxide' end
		-- }

		-- Dim inactive buffers
		-- luse {'sunjon/Shade.nvim', config = function() require 'plugins.shade' end}

		-- Keep eye on jump location
		-- luse {'edluffy/specs.nvim', config = function() require 'plugins.specs' end}

		-- Sane buffer tabline
		luse({
			"romgrk/barbar.nvim",
			setup = function()
				require("plugins.barbar")
			end,
		})

		-- Minimap
		luse({
			"wfxr/minimap.vim",
			config = function()
				require("plugins.minimap")
			end,
		})

		-- Smooth page-down and page-up
		luse({ "psliwka/vim-smoothie" })

		-- tmux compatbility
		-- luse {'tmux-plugins.vim-tmux-focus-events'}

		-- Lazygit
		luse({
			"kdheepak/lazygit.nvim",
			config = function()
				require("plugins.lazygit")
			end,
		})

		-- Dashboard
		luse({
			"glepnir/dashboard-nvim",
			config = function()
				require("plugins.dashboard")
			end,
		})

		-- Automatically make nonexistent directories
		luse({ "benizi/vim-automkdir" })

		-- wildmenu enhancements
		luse({
			"gelguy/wilder.nvim",
			config = function()
				require("plugins.wilder")
			end,
		})

		-- Restore view
		luse({
			"vim-scripts/restore_view.vim",
			config = function()
				require("plugins.restore-view")
			end,
		})

		--
		-- LANGUAGE SUPPORT
		--

		-- Asciidoctor support
		luse({
			"habamax/vim-asciidoctor",
			ft = { "asciidoc" },
			config = function()
				require("plugins.asciidoctor")
			end,
		})

		-- luseful csv utilities and highlighting
		luse({ "mechatroner/rainbow_csv", ft = { "csv" } })

		-- EBNF syntax file
		luse({ "a-vrma/ebnf-vim" })

		-- ebuild support
		luse({ "gentoo/gentoo-syntax" })

		-- editorconfig support
		luse({ "editorconfig/editorconfig-vim" })

		-- ELinks configuration syntax file
		luse({ "vim-scripts/elinks.vim" })

		-- elvish support
		luse({ "dmix/elvish.vim" })

		-- i3 configuration file syntax
		luse({ "mboughaba/i3config.vim" })

		-- LLVM IR support
		luse({ "rhysd/vim-llvm" })

		-- Better lua highlighting
		luse({ "euclidianAce/BetterLua.vim", ft = { "lua" } })

		-- mbsyncrc highlighting
		luse({ "chunkhang/vim-mbsync" })

		-- NEON filetype support
		luse({ "Dophin2009/neon-syntax.vim" })

		-- Nginx configuration highlighting
		luse({ "chr4/nginx.vim" })

		-- Pandoc support
		luse({
			"vim-pandoc/vim-pandoc",
			requires = { { "vim-pandoc/vim-pandoc-syntax" } },
			config = function()
				require("plugins.pandoc")
			end,
		})

		-- PostgreSQL support
		luse({ "lifepillar/pgsql.vim", ft = { "pgsql" } })

		-- R Markdown support
		luse({
			"vim-pandoc/vim-rmarkdown",
			after = { "vim-pandoc" },
			ft = { "rmarkdown" },
		})

		-- Reason support
		luse({ "arrowresearch/vim-reason" })

		-- Cargo.toml crate version hints
		luse({
			"mhinz/vim-crates",
			ft = { "toml" },
			config = function()
				require("plugins.vim-crates")
			end,
		})

		-- Good TeX support
		luse({
			"lervag/vimtex",
			config = function()
				require("plugins.vimtex")
			end,
		})

		-- Vader support
		luse({ "junegunn/vader.vim" })

		--
		-- WRITING
		--

		-- Distraction-free writing environment
		-- luse {'junegunn/goyo.vim', config = function() require 'plugins.goyo' end}

		-- Find poorly repeated words in writing
		-- luse {
		-- 'dbmrq/vim-ditto',
		-- ft = {'markdown', 'pandoc', 'text', 'tex'},
		-- config = function() require 'plugins.ditto' end
		-- }

		-- Thesaurus utility
		-- luse {
		-- 'ron89/thesaurus_query.vim',
		-- setup = function() require 'plugins.thesaurus_query' end
		-- }

		--
		-- THEME
		--

		-- Gruvbox material
		luse({ "sainnhe/gruvbox-material" })

		-- Nord
		luse({ "arcticicestudio/nord-vim" })

		-- Iceberg
		luse({ "cocopon/iceberg.vim" }) --

		--
		-- MISC
		--

		-- Unix command luse
		luse({ "tpope/vim-eunuch" })

		-- Popup with keybind suggestions
		luse({
			"folke/which-key.nvim",
			config = function()
				require("plugins.which-key")
			end,
		})

		-- Run code snippets
		-- luse {
		-- 'michaelb/sniprun',
		-- run = 'bash ./install.sh',
		-- config = function() require 'plugins.sniprun' end
		-- }

		-- Discord presence
		luse({
			"andweeb/presence.nvim",
			config = function()
				require("plugins.presence")
			end,
		})

		-- Per-project settings
		luse({
			"windwp/nvim-projectconfig",
			config = function()
				require("plugins.projectconfig")
			end,
		})
	end, {
		config = {
			display = {
				open_fn = function()
					return require("packer.util").float({ border = "single" })
				end,
			},
		},
	})

	-- Auto-compile on save this file
	cmd("autocmd BufWritePost " .. g.nvim_config .. "/lua/plugins/init.lua PackerCompile")
end

M.wait = function(name, f)
	co.wait(function()
		return M.status[name]
	end, f)
end

return M
