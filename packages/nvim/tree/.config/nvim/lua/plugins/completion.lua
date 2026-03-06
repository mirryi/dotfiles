return {
    {
        'SirVer/ultisnips',
        init = function()
            vim.g.UltiSnipsExpandTrigger = '<C-j>'
            vim.g.UltiSnipsListSnippets = '<NUL>'
            vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
            vim.g.UltiSnipsJumpBackwardTrigger = '<C-h>'
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'quangnguyen30192/cmp-nvim-ultisnips',
            'hrsh7th/cmp-path',
            'f3fora/cmp-spell',
            'hrsh7th/cmp-buffer',
        },
        config = function()
            local cmp = require('cmp')

            local check_back_space = function()
                local col = vim.fn.col('.') - 1
                return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
            end

            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn['UltiSnips#Anon'](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
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
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif check_back_space() then
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n', false)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'ultisnips' },
                    { name = 'path' },
                },
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = 'menu,menuone,noselect',
                    keyword_length = 2,
                },
                experimental = {
                    ghost_text = true,
                },
            }

            -- per-filetype sources
            cmp.setup.filetype('lua', {
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'ultisnips' },
                    { name = 'path' },
                },
            })

            for _, ft in ipairs { 'markdown', 'pandoc', 'tex' } do
                cmp.setup.filetype(ft, {
                    sources = {
                        { name = 'nvim_lsp' },
                        { name = 'ultisnips' },
                        { name = 'path' },
                        { name = 'spell' },
                    },
                })
            end
        end,
    },
    {
        'windwp/nvim-autopairs',
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require('nvim-autopairs').setup {
                disable_filetype = { 'TelescopePrompt' },
                ignored_next_char = '[%w%.]',
                enable_check_bracket_line = false,
                fast_wrap = {
                    map = '<C-e>',
                },
            }
        end,
    },
}
