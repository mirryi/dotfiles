local co = coroutine

local M = {}

M.poll = function(thread)
    local nxt = nil
    nxt = function(cont, ...)
        if not cont then
            return ...
        else
            return nxt(co.resume(thread, ...))
        end
    end
    return nxt(co.resume(thread))
end

M.wait = function(cond, f)
    local thread = co.create(function()
        while not cond() do co.yield(nil) end
        f()
    end)
    M.poll(thread)
end

return M
