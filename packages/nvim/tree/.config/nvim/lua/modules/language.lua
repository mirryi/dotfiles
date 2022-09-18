-- luacheck: globals vim
local plugins = {}

-- {{{ vim-agda : Agda support
-- plugins['msuperdock/vim-agda'] = {
-- requires = { { 'msuperdock/vim-foldout' } },
-- ft = { 'agda' },
-- config = function()
-- local bind = require('util.bind')
-- local bind_call = function(k, fun)
-- bind.nmap('<leader>a' .. k, '<CMD>call agda#' .. fun .. '()<CR>')
-- end

-- bind_call('l', 'load')
-- bind_call('a', 'abort')
-- bind_call('n', 'next')
-- bind_call('N', 'previous')
-- bind_call('i', 'infer')
-- bind_call('g', 'give')
-- bind_call('r', 'refine')
-- bind_call('c', 'context')
-- end,
-- }
-- }}}
-- {{{ cornelis : Agda support
plugins['isovector/cornelis'] = {
    run = { 'stack build' },
    requires = { { 'kana/vim-textobj-user' }, { 'neovimhaskell/nvim-hs.vim' }, { 'liuchengxu/vim-which-key' } },
    setup = function()
        vim.g.cornelis_no_agda_input = 1
    end,
    config = function()
        local bind = require('util.bind')
        bind.nmap('<leader>al', '<cmd>CornelisLoad<CR>')
        bind.nmap('<leader>ar', '<cmd>CornelisRefine<CR>')
        bind.nmap('<leader>ac', '<cmd>CornelisMakeCase<CR>')
        bind.nmap('<leader>ae', '<cmd>CornelisTypeContext<CR>')
        bind.nmap('<leader>as', '<cmd>CornelisSolve<CR>')
        bind.nmap('<leader>aa', '<cmd>CornelisAuto<CR>')
        bind.nmap('<leader>ag', '<cmd>CornelisGoToDefinition<CR>')
        bind.nmap('<leader>aN', '<cmd>CornelisPrevGoal<CR>')
        bind.nmap('<leader>an', '<cmd>CornelisNextGoal<CR>')

        vim.cmd([[ au BufWritePost,BufReadPre *.agda execute "normal! <cmd>CornelisLoad<CR>" ]])
        vim.cmd([[ au BufWritePost,BufReadPre *.lagda execute "normal! <cmd>CornelisLoad<CR>" ]])
    end,
}
-- }}}
-- {{{ vim-asciidoctor : Asciidoctor support
plugins['habamax/vim-asciidoctor'] = {
    ft = { 'asciidoc' },
    config = function()
        -- No coneal
        vim.g.asciidoctor_syntax_conceal = 0
    end,
}
-- }}}
-- {{{ coq-au-vim : Coq support
plugins['https://framagit.org/manu/coq-au-vim'] = {
    requires = { 'jvoorhis/coq.vim' },
}
-- }}}
-- {{{ rainbow_csv : csv utilities and highlighting
plugins['mechatroner/rainbow_csv'] = { ft = { 'csv' } }
-- }}}
-- {{{ vim-crates : Cargo.toml crate version hints
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
-- }}}
-- {{{ wmgraphviz.vim : Enhanced graphviz support
plugins['wannesm/wmgraphviz.vim'] = {}
-- }}}
-- {{{ ebnf-vim : EBNF syntax file
plugins['a-vrma/ebnf-vim'] = {}
-- }}}
-- {{{ gentoo-syntax : ebuild support
plugins['gentoo/gentoo-syntax'] = {}
-- }}}
-- {{{ editorconfig-vim : editorconfig support
plugins['editorconfig/editorconfig-vim'] = {}
-- }}}
-- {{{ elinks.vim : ELinks configuration syntax file
plugins['vim-scripts/elinks.vim'] = {}
-- }}}
-- {{{ elvish.vim : elvish support
plugins['dmix/elvish.vim'] = {}
-- }}}
-- {{{ i3config.vim : i3 configuration file syntax
plugins['mboughaba/i3config.vim'] = {}
-- }}}
-- {{{ vim-llvm : LLVM IR support
plugins['rhysd/vim-llvm'] = {}
-- }}}
-- {{{ BetterLua.vim : Better lua highlighting
plugins['euclidianAce/BetterLua.vim'] = { ft = { 'lua' } }
-- }}}
-- {{{ vim-mbsync : mbsyncrc highlighting
plugins['chunkhang/vim-mbsync'] = {}
-- }}}
-- {{{ neon-syntax.vim : NEON filetype support
plugins['mirryi/neon-syntax.vim'] = {}
-- }}}
-- {{{ nginx.vim : Nginx configuration highlighting
plugins['chr4/nginx.vim'] = {}
-- }}}
-- {{{ vim-pandoc : Pandoc support
plugins['vim-pandoc/vim-pandoc'] = {
    requires = { { 'vim-pandoc/vim-pandoc-syntax' } },
    config = function()
        -- Disable certain pandoc modules
        -- vim.g['pandoc#modules#disabled'] = { 'folding', 'spell' }
    end,
}
-- }}}
-- {{{ pgsql.vim : PostgreSQL support
plugins['lifepillar/pgsql.vim'] = { ft = { 'pgsql' } }
-- }}}
-- {{{ vim-rmarkdown : R Markdown support
plugins['vim-pandoc/vim-rmarkdown'] = {
    after = { 'vim-pandoc' },
    ft = { 'rmarkdown' },
}
-- }}}
-- {{{ vim-reason : Reason support
plugins['arrowresearch/vim-reason'] = {}
-- }}}
-- {{{ vimtex : Good TeX support
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
-- }}}
-- {{{ nabla.nvim : TeX math preview on hover
plugins['jbyuki/nabla.nvim'] = {
    config = function()
        local bind = require('util.bind')
        bind.nmap('<leader>lf', '<cmd>lua require("nabla").popup()<CR>')
    end,
}
-- }}}
-- {{{ vader.vim : Vader support
plugins['junegunn/vader.vim'] = {}
-- }}}

return plugins
