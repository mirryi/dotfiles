-- luacheck: globals vim
local plugins = {}

plugins['SirVer/ultisnips'] = {
    config = function()
        -- Disable default UltiSnips mappings
        vim.g.UltiSnipsExpandTrigger = '<C-j>'
        vim.g.UltiSnipsListSnippets = '<NUL>'
        vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
        vim.g.UltiSnipsJumpBackwardTrigger = '<C-h>'
    end,
}

plugins['hrsh7th/nvim-cmp'] = {
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'quangnguyen30192/cmp-nvim-ultisnips',
        'hrsh7th/cmp-path',
        'f3fora/cmp-spell',
        'hrsh7th/cmp-buffer',
    },
    config = function()
        local sources = function()
            local source_list = {
                { name = 'nvim_lsp' },
                { name = 'ultisnips' },
                { name = 'path' },
                -- { name = 'buffer' },
            }

            local ft = vim.o.ft
            if ft == 'lua' then
                table.insert(source_list, { name = 'nvim_lua' })
            end
            if ft == 'markdown' or ft == 'pandoc' or ft == 'tex' then
                table.insert(source_list, { name = 'spell' })
            end
            return source_list
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
                if cmp.visible() then
                    cmp.select_next_item()
                elseif check_back_space() then
                    vim.fn.feedkeys(t('<Tab>'), 'n')
                else
                    fallback()
                end
            end

            local s_tab_complete = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
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
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                },
                ['<Tab>'] = cmp.mapping(tab_complete, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(s_tab_complete, { 'i', 's' }),
            }
        end
        local cmp = require('cmp')

        cmp.setup {
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
                keyword_length = 2,
            },
            experimental = {
                ghost_text = true,
            },
        }
    end,
}

plugins['windwp/nvim-autopairs'] = {
    after = 'nvim-cmp',
    config = function()
        local autopairs = require('nvim-autopairs')
        autopairs.setup {
            disable_filetype = { 'TelescopePrompt' },
            ignored_next_char = '[%w%.]',
            enable_check_bracket_line = false,
            fast_wrap = {
                map = '<C-e>',
            },
        }
    end,
}

return plugins
