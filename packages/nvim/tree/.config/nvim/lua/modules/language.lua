-- luacheck: globals vim
local plugins = {}

-- agda support
plugins['isovector/cornelis'] = {
    build = { 'stack build' },
    dependencies = { 'kana/vim-textobj-user', 'neovimhaskell/nvim-hs.vim', 'liuchengxu/vim-which-key' },
    init = function() end,
    config = function()
        vim.keymap.set('n', '<leader>al', '<cmd>CornelisLoad<CR>')
        vim.keymap.set('n', '<leader>aG', '<cmd>CornelisGoals<CR>')
        vim.keymap.set('n', '<leader>aR', '<cmd>CornelisRestart<CR>')
        vim.keymap.set('n', '<leader>aA', '<cmd>CornelisAbort<CR>')
        vim.keymap.set('n', '<leader>as', '<cmd>CornelisSolve<CR>')
        vim.keymap.set('n', '<leader>ad', '<cmd>CornelisGoToDefinition<CR>')
        vim.keymap.set('n', '<leader>aN', '<cmd>CornelisPrevGoal<CR>')
        vim.keymap.set('n', '<leader>an', '<cmd>CornelisNextGoal<CR>')
        vim.keymap.set('n', '<leader>aM', '<cmd>CornelisQuestionToMeta<CR>')
        vim.keymap.set('n', '<leader>aC', '<cmd>CornelisCloseInfoWindows<CR>')

        vim.keymap.set('n', '<leader>ag', '<cmd>CornelisGive<CR>')
        vim.keymap.set('n', '<leader>ar', '<cmd>CornelisRefine<CR>')
        vim.keymap.set('n', '<leader>aL', '<cmd>CornelisElaborate<CR>')
        vim.keymap.set('n', '<leader>aa', '<cmd>CornelisAuto<CR>')
        vim.keymap.set('n', '<leader>ac', '<cmd>CornelisMakeCase<CR>')
        vim.keymap.set('n', '<leader>ae', '<cmd>CornelisTypeContext<CR>')
        vim.keymap.set('n', '<leader>ai', '<cmd>CornelisTypeInfer<CR>')
        vim.keymap.set('n', '<leader>aE', '<cmd>CornelisTypeContextInfer<CR>')
        vim.keymap.set('n', '<leader>aN', '<cmd>CornelisNormalize<CR>')
        vim.keymap.set('n', '<leader>aw', '<cmd>CornelisWhyInScope<CR>')
    end,
}

-- asciidoctor support
plugins['habamax/vim-asciidoctor'] = {
    ft = { 'asciidoc' },
    config = function()
        -- No coneal
        vim.g.asciidoctor_syntax_conceal = 0
    end,
}

-- Coq support
plugins['whonore/Coqtail'] = {}
-- plugins['https://framagit.org/manu/coq-au-vim'] = {
-- requires = { 'jvoorhis/coq.vim' },
-- }

-- csv utilities and highlighting
plugins['mechatroner/rainbow_csv'] = { ft = { 'csv' } }

-- cargo crate version hints
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

-- enhanced graphviz support
plugins['wannesm/wmgraphviz.vim'] = {}

-- ebnf syntax support
plugins['a-vrma/ebnf-vim'] = {}

-- ebuild support
plugins['gentoo/gentoo-syntax'] = {}

-- editorconfig support
plugins['editorconfig/editorconfig-vim'] = {}

-- elinks configuration syntax file
plugins['vim-scripts/elinks.vim'] = {}

-- elvish support
plugins['dmix/elvish.vim'] = {}

-- forester support
plugins['kentookura/forester.nvim'] = {
    ft = { 'forester' },
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-lua/plenary.nvim',
    },
    -- after = { 'hrsh7th/nvim-cmp' },
    config = function()
        local forester = require('forester')
        forester.setup {}

        -- local cmp_source = require('forester.completion')
        -- require('cmp').register_source('forester', cmp_source)
        -- require('cmp').setup.filetype('forester', { sources = { { name = 'forester', dup = 0 } } })
    end,
}

-- i3 configuration file syntax
plugins['mboughaba/i3config.vim'] = {}

-- llvm ir support
plugins['rhysd/vim-llvm'] = {}

-- better lua highlighting
plugins['euclidianAce/BetterLua.vim'] = { ft = { 'lua' } }

-- mbsyncrc highlighting
plugins['chunkhang/vim-mbsync'] = {}

-- neon filetype support
plugins['mirryi/neon-syntax.vim'] = {}

-- nginx configuration highlighting
plugins['chr4/nginx.vim'] = {}

-- nickel highlighting
plugins['nickel-lang/vim-nickel'] = {}

-- nusmv syntax
plugins['wannesm/wmnusmv.vim'] = {}

-- pandoc support
plugins['vim-pandoc/vim-pandoc'] = {
    dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
    config = function()
        -- Disable certain pandoc modules
        -- vim.g['pandoc#modules#disabled'] = { 'folding', 'spell' }
    end,
}

-- postgresql support
plugins['lifepillar/pgsql.vim'] = { ft = { 'pgsql' } }

-- r markdown support
plugins['vim-pandoc/vim-rmarkdown'] = {
    after = { 'vim-pandoc' },
    ft = { 'rmarkdown' },
}

-- reasonml support
plugins['arrowresearch/vim-reason'] = {}

-- sagemath
plugins['petRUShka/vim-sage'] = {}

-- smtlib
plugins['bohlender/vim-smt2'] = {}

-- tex support
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

        -- Fold options
        g.vimtex_fold_enabled = 1
        g.vimtex_fold_levelmarker = ':'
        g.vimtex_fold_types = { items = { enabled = 0 } }

        -- View options
        g.vimtex_view_method = 'zathura'

        local au_group = vim.api.nvim_create_augroup('vimtex_events', {})
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VimtexEventView',
            group = au_group,
            command = 'call b:vimtex.viewer.xdo_focus_vim()',
        })
    end,
}

-- tex math preview on hover
plugins['jbyuki/nabla.nvim'] = {
    ft = { 'latex' },
    config = function()
        vim.keymap.set('n', '<leader>lf', function()
            require('nabla').popup()
        end)
    end,
}

-- typst support
plugins['kaarmu/typst.vim'] = {
    ft = { 'typst' },
    lazy = false,
}

-- typst preview
plugins['chomosuke/typst-preview.nvim'] = {
    ft = { 'typst' },
}

-- vader support
plugins['junegunn/vader.vim'] = {}

return plugins
