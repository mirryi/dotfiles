-- luacheck: globals vim
local bind = require('util.bind')
local g, exec = vim.g, vim.api.nvim_exec

local config = {}

config.goyo = function()
	-- Set width of window
	g.goyo_width = 85

	-- Toggle goyo
	bind.nmap('<leader>G', '<cmdGoyo<CR>', { silent = true })

	-- Set custom enter/exit hooks
	exec(
		[[
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
]],
		true
	)
end

config.ditto = function()
	-- Some bindings
	bind.nmap('<leader>di', '<cmd>ToggleDitto<CR>')
	bind.nmap('<leader>=d', '<Plug>DittoNext')
	bind.nmap('<leader>-d', '<Plug>DittoPrev')
	bind.nmap('<leader>+d', '<Plug>DittoGood')
	bind.nmap('<leader>_d', '<Plug>DittoBad')
	bind.nmap('<leader>]d', '<Plug>DittoMore')
	bind.nmap('<leader>[d', '<Plug>DittoLess')
end

config.thesaurus = function()
	-- Disable default keybinds
	g.tq_map_keys = 0

	-- Use custom keybind
	bind.nmap('<leader>t', '<cmd>ThesaurusQueryReplaceCurrentWord<CR>')
end

return config
