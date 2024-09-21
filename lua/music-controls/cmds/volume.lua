local notify = require('notify')
local utils = require('music-controls.utils')
local M = {}

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

  local cmd = string.format('playerctl -p %s volume', player)
  local result = tonumber(string.format('%.2f', utils.exec_command(cmd)))

  notify(
    string.format('Volume: %s', convert_volume_to_percentage(result)),
    'info',
    { title = string.format('Music Controls (%s)', player) }
  )
end

return M
