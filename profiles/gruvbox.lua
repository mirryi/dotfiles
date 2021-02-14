local M = {}

local font = 'JetBrains Mono Nerd Font'

local colors = {
    bright = {
        black = '#928374',
        blue = '#7daea3',
        cyan = '#89b482',
        green = '#a9b665',
        magenta = '#d3869b',
        red = '#ea6962',
        white = '#dfdf8e',
        yellow = '#e3a84e'
    },
    normal = {
        black = '#665c54',
        blue = '#7daea3',
        cyan = '#89b482',
        green = '#a9b665',
        magenta = '#d3869b',
        red = '#ea6962',
        white = '#dfdf8e',
        yellow = '#e78a4e'
    },
    primary = {
        background = '#282828',
        foreground = '#ebdbb2',
        alarm = '#ea6962'
    }
}

M.alacritty = {font = font, colors = colors, font_size = 10}

M.bat = {theme = 'gruvbox'}

M.discord = {theme = 'gruvbox'}

M.dunst = {
    font = {family = font, size = 9},
    colors = {
        low = {foreground = colors.primary.foreground, background = '#32302f'},
        normal = {
            foreground = colors.primary.foreground,
            background = '#32302f'
        },
        critical = {
            foreground = colors.primary.background,
            background = colors.primary.alarm
        }
    }
}

M.fzf = {name = 'gruvbox'}

M.git = {delta = {theme = 'gruvbox'}}

M.gtk = {theme = 'gruvbox-gtk'}

M.hangups = {theme = 'solarized-dark'}

M.i3 = {
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
    gaps = {inner = 5, outer = 0}
}

M.nvim = {theme = 'gruvbox-dark'}

M.polybar = {
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

M.qutebrowser = {theme = 'gruvbox-dark-medium'}

M.rofi = {font = font, theme = 'gruvbox-dark-hard'}

M.task = {theme = 'dark-256'}

M.termite = {
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

M.tmux = {theme = 'gruvbox'}

M.x11 = {
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

M.wallpaper = {name = 'gruvbox'}

return M
