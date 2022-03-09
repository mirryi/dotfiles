local M = {}

M.basename = function(path)
    return vim.fn.fnamemodify(path, ':h')
end

M.is_dir = function(path)
    return vim.fn.isdirectory(path) == 1
end

M.is_file = function(path)
    return vim.fn.filereadable(path) == 1
end

M.exists = function(path)
    return M.is_file(path) or M.is_dir(path)
end

M.mkdir = function(path)
    vim.fn.mkdir(path)
end

M.mkdir_all = function(path)
    if M.is_file(path) then
        return false
    end

    if not M.is_dir(path) then
        vim.fn.mkdir(path, 'p')
        return true
    end
end

M.open = function(path, mode)
    return io.open(path, mode)
end

M.create = function(path)
    return M.open(path, 'w')
end

M.create_all = function(path)
    M.mkdir_all(M.basename(path))
    return M.create(path)
end

return M
