-- luacheck: globals vim
local plugins = {}

-- rgb, hex color highlighting
plugins['norcalli/nvim-colorizer.lua'] = {
    config = function()
        local colorizer = require('colorizer')
        colorizer.setup {
            '*',
            css = { rgb_fn = true },
            html = { names = false },
            pandoc = { names = false },
            tex = { names = false },
        }
    end,
}

-- indent guides
plugins['lukas-reineke/indent-blankline.nvim'] = {
    config = function()
        local g = vim.g

        -- Set guide character
        g.indentLine_char = 'ˌ'
        -- Disable on dashboard
        g.indentLine_fileTypeExclude = { 'dashboard' }
        -- Disable setting concealcursor
        g.indentLine_setConceal = 0
    end,
}

-- in-editor markdown preview
plugins['npxbr/glow.nvim'] = {
    ft = { 'markdown', 'pandoc' },
    config = function()
        local bind = require('util.bind')
        bind.nmap('<leader>p', '<cmd>Glow<CR>')
    end,
}

-- web markdown preview
plugins['iamcco/markdown-preview.nvim'] = {
    build = 'cd app && yarn install',
    config = function()
        vim.g.mkdp_auto_start = false
        vim.g.mkdp_echo_preview_url = 1
        vim.g.mkdp_filetypes = { 'markdown', 'pandoc' }
    end,
}

-- a prettier quickfix window
plugins['https://gitlab.com/yorickpeterse/nvim-pqf.git'] = {
    config = function()
        local pqf = require('pqf')
        pqf.setup()
    end,
}

plugins['Pocco81/true-zen.nvim'] = {}

return plugins
