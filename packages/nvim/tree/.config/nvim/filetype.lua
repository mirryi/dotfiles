vim.filetype.add {
    extension = {
        md = 'pandoc',
        dfy = 'dafny',
        elpi = 'elpi',
        hbs = 'handlebars',
        tree = 'forester',
    },
    filename = {
        ['latexmkrc'] = 'perl',
        ['.latexmkrc'] = 'perl',
        ['.luacheckrc'] = 'lua',
        ['rust-toolchain'] = 'toml',
    },
    pattern = {
        [vim.env.HOME .. '/.config/i3/config'] = 'i3config',
        -- compound extensions for handlebars templates
        ['.*%.i3config%.hbs'] = 'i3config.handlebars',
        ['.*%.yaml%.hbs'] = 'yaml.handlebars',
        ['.*%.yml%.hbs'] = 'yaml.handlebars',
    },
}
