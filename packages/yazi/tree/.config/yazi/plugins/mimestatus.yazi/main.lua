-- yazi never exposes its computed mime to Lua, so the bar detects it itself.
-- xdg-mime pre-checks readability and exits nonzero, so failures need no parsing.
local hovered = ya.sync(function()
    local h = cx.active.current.hovered
    return h and tostring(h.url) or nil
end)

local save = ya.sync(function(st, url, mime)
    st[url] = mime
    ui.render()
end)

local M = {}

function M:setup()
    local st = self
    Status:children_add(function()
        local h = cx.active.current.hovered
        if not h then
            return ''
        end

        -- This runs every frame; the pending marker keeps it to one spawn per file.
        local url = tostring(h.url)
        if st[url] == nil then
            st[url] = false
            ya.emit('plugin', { 'mimestatus' })
        end

        if not st[url] then
            return ''
        end
        return ui.Line { ui.Span(st[url]):fg('blue'), ui.Span(' ') }
    end, 400, Status.RIGHT)
end

function M:entry()
    local url = hovered()
    if not url then
        return
    end

    local output = Command('xdg-mime'):arg({ 'query', 'filetype', url }):output()
    if output and output.status.success then
        save(url, output.stdout:gsub('%s+$', ''))
    end
end

return M
