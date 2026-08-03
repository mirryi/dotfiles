return {
    {
        'zk-org/zk-nvim',
        name = 'zk',
        dependencies = { 'hrsh7th/cmp-nvim-lsp' },
        config = function()
            require('zk').setup {
                lsp = {
                    config = {
                        filetypes = { 'markdown', 'pandoc' },
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                    },
                },
            }

            -- bump `modified:` in frontmatter of notes in a zk notebook
            vim.api.nvim_create_autocmd('BufWritePre', {
                pattern = '*.md',
                callback = function(args)
                    local name = vim.api.nvim_buf_get_name(args.buf)
                    if not require('zk.util').notebook_root(name) then
                        return
                    end

                    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
                    if lines[1] ~= '---' then
                        return
                    end

                    local new_line = 'modified: ' .. os.date('%Y-%m-%d %H:%M')
                    for i = 2, #lines do
                        if lines[i] == '---' then
                            -- no `modified:` yet; add one at the end of the frontmatter
                            vim.api.nvim_buf_set_lines(args.buf, i - 1, i - 1, false, { new_line })
                            return
                        elseif lines[i]:match('^modified:') then
                            vim.api.nvim_buf_set_lines(args.buf, i - 1, i, false, { new_line })
                            return
                        end
                    end
                end,
            })
        end,
    },
    {
        -- writing focus
        'folke/zen-mode.nvim',
        opts = {
            window = {
                backdrop = 1,
                height = 0.95,
                options = {
                    number = false,
                    relativenumber = false,
                },
            },
            plugins = {
                gitsigns = { enabled = true },
            },
        },
    },
    {
        -- soft wrap long lines
        'mirryi/vim-longlines',
        config = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'pandoc',
                callback = function()
                    vim.cmd('LongLines')
                end,
            })
        end,
    },
    {
        -- smart quotes
        'preservim/vim-textobj-quote',
    },
    {
        -- text formatting for Japanese
        'fuenor/JpFormat.vim',
    },
    {
        -- in-editor markdown preview
        'ellisonleao/glow.nvim',
        ft = { 'markdown', 'pandoc' },
        config = function()
            vim.keymap.set('n', '<leader>p', '<cmd>Glow<CR>')
        end,
    },
    {
        -- web markdown preview
        'iamcco/markdown-preview.nvim',
        build = 'cd app && yarn install',
        config = function()
            vim.g.mkdp_auto_start = false
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_filetypes = { 'markdown', 'pandoc' }
        end,
    },
}
