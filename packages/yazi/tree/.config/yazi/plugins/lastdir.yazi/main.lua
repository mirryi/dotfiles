-- Toggle between the current and previously visited directory, like vim's ''.
local M = {}

-- ponytail: one shared prev across all tabs; key it by tab id if that ever bites
local swap = ya.sync(function(st, cwd)
    if cwd ~= st.cur then
        st.prev, st.cur = st.cur, cwd
    end
end)

local prev = ya.sync(function(st)
    return st.prev
end)

function M:setup()
    ps.sub('cd', function()
        local cwd = tostring(cx.active.current.cwd)
        ya.async(function()
            swap(cwd)
        end)
    end)
end

function M:entry()
    local p = prev()
    if p then
        ya.emit('cd', { p, raw = true })
    else
        -- nothing visited yet this session
        ya.emit('back', {})
    end
end

return M
