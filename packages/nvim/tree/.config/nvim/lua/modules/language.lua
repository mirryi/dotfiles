-- luacheck: globals vim
local plugins = {}

-- agda support
plugins['isovector/cornelis'] = {
    build = { 'stack build' },
    dependencies = { 'kana/vim-textobj-user', 'neovimhaskell/nvim-hs.vim', 'liuchengxu/vim-which-key' },
    init = function() end,
    config = function()
        local bind = require('util.bind')
        bind.nmap('<leader>al', '<cmd>CornelisLoad<CR>')
        bind.nmap('<leader>aG', '<cmd>CornelisGoals<CR>')
        bind.nmap('<leader>aR', '<cmd>CornelisRestart<CR>')
        bind.nmap('<leader>aA', '<cmd>CornelisAbort<CR>')
        bind.nmap('<leader>as', '<cmd>CornelisSolve<CR>')
        bind.nmap('<leader>ad', '<cmd>CornelisGoToDefinition<CR>')
        bind.nmap('<leader>aN', '<cmd>CornelisPrevGoal<CR>')
        bind.nmap('<leader>an', '<cmd>CornelisNextGoal<CR>')
        bind.nmap('<leader>aM', '<cmd>CornelisQuestionToMeta<CR>')
        bind.nmap('<leader>aC', '<cmd>CornelisCloseInfoWindows<CR>')

        bind.nmap('<leader>ag', '<cmd>CornelisGive<CR>')
        bind.nmap('<leader>ar', '<cmd>CornelisRefine<CR>')
        bind.nmap('<leader>aL', '<cmd>CornelisElaborate<CR>')
        bind.nmap('<leader>aa', '<cmd>CornelisAuto<CR>')
        bind.nmap('<leader>ac', '<cmd>CornelisMakeCase<CR>')
        bind.nmap('<leader>ae', '<cmd>CornelisTypeContext<CR>')
        bind.nmap('<leader>ai', '<cmd>CornelisTypeInfer<CR>')
        bind.nmap('<leader>aE', '<cmd>CornelisTypeContextInfer<CR>')
        bind.nmap('<leader>aN', '<cmd>CornelisNormalize<CR>')
        bind.nmap('<leader>aw', '<cmd>CornelisWhyInScope<CR>')
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
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-lua/plenary.nvim',
        'hrsh7th/nvim-cmp',
    },
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

-- latex support
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
    end,
}

-- tex math preview on hover
plugins['jbyuki/nabla.nvim'] = {
    ft = { 'latex' },
    config = function()
        local bind = require('util.bind')
        bind.nmap('<leader>lf', '<cmd>lua require("nabla").popup()<CR>')
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
