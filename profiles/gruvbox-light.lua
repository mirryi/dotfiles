local font = 'JetBrains Mono Nerd Font'

local colors = {
    normal = {
        black = '#654735',
        red = '#c14a4a',
        green = '#6c782e',
        yellow = '#b47109',
        blue = '#45707a',
        magenta = '#945e80',
        cyan = '#4c7a5d',
        white = '#eee0b7',
    },
    bright = {
        black = '#654735',
        red = '#c14a4a',
        green = '#6c782e',
        yellow = '#b47109',
        blue = '#45707a',
        magenta = '#945e80',
        cyan = '#4c7a5d',
        white = '#eee0b7',
    },
    primary = {
        background = '#fbf1c7',
        foreground = '#282828',
        alarm = '#ea6962',
    },
}

local M = {
    alacritty = { font = font, colors = colors, font_size = 10 },
    bat = { theme = 'gruvbox-light' },
    dunst = {
        font = { family = font, size = 9 },
        colors = {
            low = {
                foreground = colors.primary.foreground,
                background = colors.primary.background,
            },
            normal = {
                foreground = colors.primary.foreground,
                background = colors.primary.background,
            },
            critical = {
                foreground = colors.primary.background,
                background = colors.primary.alarm,
            },
        },
    },
    fzf = { name = 'gruvbox-light' },
    git = { delta = { theme = 'gruvbox' } },
    gtk = { theme = 'gruvbox-gtk' },
    i3 = {
        font = { family = font, size = 10 },
        colors = {
            foc = {
                border = colors.primary.background,
                bg = colors.primary.background,
                text = colors.primary.foreground,
                indic = colors.primary.background,
                cborder = colors.bright.white,
            },
            foc_in = {
                border = colors.primary.background,
                bg = colors.primary.background,
                text = colors.primary.foreground,
                indic = colors.primary.background,
                cborder = colors.primary.background,
            },
            unfoc = {
                border = colors.primary.background,
                bg = colors.primary.background,
                text = colors.primary.foreground,
                indic = colors.primary.background,
                cborder = colors.primary.background,
            },
            urgent = {
                border = colors.primary.background,
                bg = colors.primary.background,
                text = colors.primary.foreground,
                indic = colors.primary.background,
                cborder = colors.primary.background,
            },
            ph = {
                border = colors.primary.background,
                bg = colors.primary.background,
                text = colors.primary.foreground,
                indic = colors.primary.background,
                cborder = colors.primary.background,
            },
        },
        gaps = { inner = 5, outer = 0 },
    },
    nvim = { theme = 'gruvbox/light' },
    polybar = {
        font = font,
        colors = {
            black = colors.normal.black,
            darkgray = colors.normal.foreground,
            gray = colors.bright.foreground,
            white = colors.bright.white,
            darkred = colors.normal.red,
            red = colors.bright.red,
            darkblue = colors.normal.blue,
            blue = colors.bright.blue,
            darkyellow = colors.normal.yellow,
            yellow = colors.bright.yellow,
            darkcyan = colors.normal.cyan,
            cyan = colors.bright.cyan,
            background = colors.primary.background,
            foreground = colors.primary.foreground,
            alert = colors.primary.alarm,
        },
    },
    rofi = { font = font, theme = 'gruvbox-light-soft' },
    tmux = { theme = 'gruvbox-light' },
    x11 = {
        colors = {
            background = colors.primary.background,
            foreground = colors.primary.foreground,
            c0 = colors.normal.black,
            c1 = colors.normal.red,
            c2 = colors.normal.green,
            c3 = colors.normal.yellow,
            c4 = colors.normal.blue,
            c5 = colors.normal.magenta,
            c6 = colors.normal.cyan,
            c7 = colors.normal.white,
            c8 = colors.bright.black,
            c9 = colors.bright.red,
            c10 = colors.bright.green,
            c11 = colors.bright.yellow,
            c12 = colors.bright.blue,
            c13 = colors.bright.magenta,
            c14 = colors.bright.cyan,
            c15 = colors.bright.white,
        },
    },
    wallpaper = { name = 'gruvbox-light' },
    zathura = { theme = 'gruvbox-light' },
}

return M
