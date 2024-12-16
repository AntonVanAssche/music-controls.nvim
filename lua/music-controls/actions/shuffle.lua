local utils = require('music-controls.utils')

local M = {}

local _get_shuffle = function(player)
  local cmd = { 'playerctl', '-p', player, 'shuffle' }
  local state, err = utils.exec_command(cmd)
  if err then
    return 'Unknown'
  end

  return state and state:match('^%s*(.-)%s*$') or 'Unknown'
end

local _set_shuffle = function(player, state)
  local cmd = { 'playerctl', '-p', player, 'shuffle', state }
  local _, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: ' .. err)
    return false
  end

  return true
end

M.toggle = function(player)
  local shuffle_state = _get_shuffle(player)
  local new_state = (shuffle_state == 'Off') and 'On' or 'Off'
  local success = _set_shuffle(player, new_state)
  if not success then
    return
  end

  return new_state
end

return M
