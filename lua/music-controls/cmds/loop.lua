local utils = require('music-controls.utils')
local M = {}

local function loop_state(player)
  local cmd = string.format('playerctl -p %s loop', player)
  return utils.exec_command(cmd)
end

M.loop = function(player, mode)
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

  local loop_mode = mode or 'Track'
  local cmd = string.format('playerctl -p %s loop %s', player, loop_mode)
  local success, _ = pcall(utils.exec_command, cmd)
  if not success then
    return {
      state = nil,
      msg = 'Failed to set loop mode',
      lvl = 'error',
      meta = { title = 'Music Controls' },
    }
  end

  utils.sleep(0.25)
  local state = loop_state(player)
  return {
    state = state,
    msg = string.format('Loop mode: %s', state),
    lvl = 'info',
    meta = { title = string.format('Music Controls (%s)', player) },
  }
end

M.loop_toggle = function(player)
  if not player then
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

  local current_state = loop_state(player)
  local new_mode = (current_state == 'None') and 'Track' or 'None'
  return M.loop(player, new_mode)
end

return M
