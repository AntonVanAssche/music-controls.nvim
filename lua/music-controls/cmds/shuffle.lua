local utils = require('music-controls.utils')
local M = {}

local function shuffle_state(player)
  local cmd = string.format('playerctl -p %s shuffle', player)
  return utils.exec_command(cmd)
end

M.shuffle = function(player)
  if not player or player == '' then
    return {
      state = nil,
      msg = 'No player found',
      lvl = 'warn',
      meta = { title = 'Music Controls' },
    }
  end

  if not utils.check_playerctl_installed() then
    return {
      state = nil,
      msg = 'Playerctl is not installed',
      lvl = 'error',
      meta = { title = 'Music Controls' },
    }
  end

  local state = shuffle_state(player)
  local new_state = (state == 'Off') and 'on' or 'off'
  local cmd = string.format('playerctl -p %s shuffle %s', player, new_state)

  local success, _ = pcall(utils.exec_command, cmd)
  if not success then
    return {
      state = nil,
      msg = 'Failed to toggle shuffle',
      lvl = 'error',
      meta = { title = 'Music Controls' },
    }
  end

  return {
    state = nil,
    msg = string.format('Shuffle mode: %s', new_state),
    lvl = 'info',
    meta = { title = string.format('Music Controls (%s)', player) },
  }
end

return M
