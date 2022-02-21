local M = {}

local getenv = function(var, def)
	local env = os.getenv(var)
	return env and env or def
end

M.config = getenv('XDG_CONFIG_HOME', '~/.config') .. '/nvim'
M.data = getenv('XDG_DATA_HOME', '~/.local/share') .. '/nvim'
M.cache = getenv('XDG_CACHE_HOME', '~/.cache') .. '/nvim'

return M
