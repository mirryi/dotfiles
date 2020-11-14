local font = 'Iosevka Nerd Font'

local colors = {
    bright = {
        black = '#6b7089',
        blue = '#91acd1',
        cyan = '#95c4ce',
        green = '#c0ca8e',
        magenta = '#ada0d3',
        red = '#e98989',
        white = '#d2d4de',
        yellow = '#e9b189'
    },
    normal = {
        black = '#161821',
        blue = '#84a0c6',
        cyan = '#89b8c2',
        green = '#b4be82',
        magenta = '#a093c7',
        red = '#e27878',
        white = '#c6c8d1',
        yellow = '#e2a478'
    },
    primary = {
        background = '#161821',
        foreground = '#d2d4de',
        alarm = '#e27878'
    }
}

local alacritty = {font = font, colors = colors}

local bat = {theme = '1337'}

local dunst = {
    font = font,
    colors = {
        low = {
            foreground = colors.primary.foreground,
            background = colors.bright.black
        },
        normal = {
            foreground = colors.primary.foreground,
            background = colors.bright.black
        },
        critical = {
            foreground = colors.primary.background,
            background = colors.primary.alarm
        }
    }
}

local gtk = {theme = 'gruvbox-gtk'}

local hangups = {theme = 'solarized-dark'}

local i3 = {
    font = {family = font, size = 10},
    colors = {
        foc = {
            border = colors.primary.background,
            bg = colors.primary.background,
            text = colors.primary.foreground,
            indic = colors.primary.background,
            cborder = colors.bright.white
        },
        foc_in = {
            border = colors.primary.background,
            bg = colors.primary.background,
            text = colors.primary.foreground,
            indic = colors.primary.background,
            cborder = colors.normal.white
        },
        unfoc = {
            border = colors.primary.background,
            bg = colors.primary.background,
            text = colors.primary.foreground,
            indic = colors.primary.background,
            cborder = colors.normal.white
        },
        urgent = {
            border = colors.primary.background,
            bg = colors.primary.background,
            text = colors.primary.foreground,
            indic = colors.primary.background,
            cborder = colors.normal.white
        },
        ph = {
            border = colors.primary.background,
            bg = colors.primary.background,
            text = colors.primary.foreground,
            indic = colors.primary.background,
            cborder = colors.normal.white
        }
    },
    gaps = {inner = 0, outer = 0}
}

local nvim = {theme = 'iceberg'}

local polybar = {
    font = font,
    colors = {
        black = colors.normal.black,
        darkgray = colors.bright.black,
        gray = colors.normal.white,
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
        alert = colors.primary.alarm
    }
}

local qutebrowser = {theme = 'iceberg'}

local rofi = {font = font, theme = 'iceberg'}

local task = {theme = 'dark-256'}

local termite = {
    font = {family = font, size = 9},
    colors = {
        background = colors.primary.background,
        foreground = colors.primary.foreground,
        foregroundBold = colors.primary.foreground,
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
        c15 = colors.bright.white
    }
}

local tmux = {theme = 'iceberg'}

local x11 = {
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
        c15 = colors.bright.white
    }
}

local wallpaper = {name = 'iceberg'}

return {
    alacritty = alacritty,
    bat = bat,
    dunst = dunst,
    gtk = gtk,
    hangups = hangups,
    i3 = i3,
    nvim = nvim,
    qutebrowser = qutebrowser,
    polybar = polybar,
    rofi = rofi,
    task = task,
    termite = termite,
    tmux = tmux,
    wallpaper = wallpaper,
    x11 = x11
}
