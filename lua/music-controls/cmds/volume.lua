local notify = require('notify')
local utils = require('music-controls.utils')
local M = {}

local is_valid_volume = function(volume)
  return volume ~= nil
end

local get_volume = function(player)
  local cmd = string.format('playerctl -p %s volume', player)
  return tonumber(string.format('%.2f', utils.exec_command(cmd)))
end

local convert_volume_to_percentage = function(volume)
  return string.format('%.2f', volume * 100)
end

M.current_volume = function(player)
  if not player then
    return notify('No player found', 'error', { title = 'Music Controls' })
  end

  if not utils.check_playerctl_installed() then
    return notify('Playerctl is not installed', 'error', { title = 'Music Controls' })
  end

  notify(
    string.format('Volume: %s', convert_volume_to_percentage(get_volume(player))),
    'info',
    { title = string.format('Music Controls (%s)', player) }
  )
end

M.set_volume = function(player, volume)
  volume = tonumber(volume)
  if not player then
    return notify('No player found', 'error', { title = 'Music Controls' })
  end

  if not utils.check_playerctl_installed() then
    return notify('Playerctl is not installed', 'error', { title = 'Music Controls' })
  end

  if not is_valid_volume(volume) then
    return notify('Invalid volume value', 'error', { title = 'Music Controls' })
  end

  local cmd = string.format('playerctl -p %s volume %s', player, volume)
  utils.exec_command(cmd)

  utils.sleep(0.5)
  notify(
    string.format('Volume set to: %s', convert_volume_to_percentage(get_volume(player))),
    'info',
    { title = string.format('Music Controls (%s)', player) }
  )
end

return M
