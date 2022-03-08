local M = {}

--@generic T
--@return
M.make = function()
    local S = {
        id = 0,
        dict = {},
    }

    S.create = function(v)
        S.dict[S.id] = v
        local id = S.id
        S.id = S.id + 1
        return id
    end

    S.lookup = function(id)
        return S.dict[id]
    end

    return S
end

return M
