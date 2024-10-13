local utils = require('music-controls.utils')
local M = {}

local is_valid_volume = function(volume)
  return volume ~= nil and volume >= 0 and volume <= 1
end

local get_volume = function(player)
  local cmd = string.format('playerctl -p %s volume', player)
  local success, _ = pcall(utils.exec_command, cmd)
  if not success then
    return 0
  end

  return tonumber(string.format('%.2f', utils.exec_command(cmd)))
end

local convert_volume_to_percentage = function(volume)
  return string.format('%.2f', volume * 100)
end

M.current_volume = function(player)
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

  local volume = get_volume(player)
  return {
    state = nil,
    msg = string.format('Current volume: %s', convert_volume_to_percentage(volume)),
    lvl = 'info',
    meta = { title = string.format('Music Controls (%s)', player) },
  }
end

M.set_volume = function(player, volume)
  volume = tonumber(volume)
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

  if not is_valid_volume(volume) then
    return {
      state = nil,
      msg = 'Invalid volume value',
      lvl = 'error',
      meta = { title = 'Music Controls' },
    }
  end

  local cmd = string.format('playerctl -p %s volume %s', player, volume)
  local success, _ = pcall(utils.exec_command, cmd)
  if not success then
    return {
      state = nil,
      msg = 'Failed to set volume',
      lvl = 'error',
      meta = { title = 'Music Controls' },
    }
  end

  utils.sleep(0.5)
  local new_volume = get_volume(player)
  return {
    state = nil,
    msg = string.format('Volume set to: %s', convert_volume_to_percentage(new_volume)),
    lvl = 'info',
    meta = { title = string.format('Music Controls (%s)', player) },
  }
end

return M
