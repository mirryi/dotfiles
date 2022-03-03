--
-- Keybinding utilities
--
local M = {}

local map_opts = function(rhs, opts)
    if type(rhs) == 'function' then
        opts.callback = rhs
        rhs = opts.desc or ''
    end

	local new_opts = { noremap = true, silent = true }
	if opts then
		new_opts = vim.tbl_extend('force', new_opts, opts)
	end

	return {rhs = rhs, opts = new_opts}
end

-- Bind a key for some mode.
M.map = function(mode, lhs, rhs, opts)
    local modified = map_opts(rhs, opts)
	vim.api.nvim_set_keymap(mode, lhs, modified.rhs, modified.opts)
end

M.map_list = function(list)
	for _, opts in ipairs(list) do
		M.map(opts[1], opts[2], opts[3], opts[4])
	end
end

-- Bind a key for normal mode.
M.nmap = function(lhs, rhs, opts)
	M.map('n', lhs, rhs, opts)
end

-- Bind a key for visual mode.
M.vmap = function(lhs, rhs, opts)
	M.map('v', lhs, rhs, opts)
end

-- Bind a key for insert mode.
M.imap = function(lhs, rhs, opts)
	M.map('i', lhs, rhs, opts)
end

-- Bind a key for select mode.
M.smap = function(lhs, rhs, opts)
	M.map('s', lhs, rhs, opts)
end

M.buf = {
	-- Bind a key for the given buffer.
	map = function(bufnr, mode, lhs, rhs, opts)
        local modified = map_opts(rhs, opts)
		vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, modified.rhs, modified.opts)
	end,

	nmap = function(bufnr, lhs, rhs, opts)
		M.buf.map(bufnr, 'n', lhs, rhs, opts)
	end,
}

return M
