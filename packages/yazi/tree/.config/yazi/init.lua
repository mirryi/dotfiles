require('git'):setup {
    order = 1500,
}

require('lastdir'):setup()

require('yamb'):setup {
    jump_notify = true,
    cli = 'fzf',
}

-- btime/mtime of hovered file
Status:children_add(function(self)
    local h = self._current.hovered
    if not h then
        return ''
    end

    local function fmt(t)
        return t and os.date('%Y-%m-%d %H:%M', math.floor(t)) or '-'
    end

    return ui.Line {
        ui.Span('C '):fg('cyan'),
        ui.Span(fmt(h.cha.btime)),
        ui.Span(' M '):fg('yellow'),
        ui.Span(fmt(h.cha.mtime)),
        ui.Span(' '),
    }
end, 500, Status.RIGHT)
