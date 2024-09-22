local notify = require('notify')
local utils = require('music-controls.utils')
local M = {}

local function shuffle_state(player)
  local cmd = string.format('playerctl -p %s shuffle', player)
  return utils.exec_command(cmd)
end

M.shuffle = function(player)
  if not player then
    return notify('No player found', 'error', { title = 'Music Controls' })
  end

  if not utils.check_playerctl_installed() then
    return notify('Playerctl is not installed', 'error', { title = 'Music Controls' })
  end

  local state = shuffle_state(player)
  if state == 'Off' then
    local cmd = string.format('playerctl -p %s shuffle on', player)
    utils.exec_command(cmd)
    notify('Shuffle mode: On', 'info', { title = string.format('Music Controls (%s)', player) })
  else
    local cmd = string.format('playerctl -p %s shuffle off', player)
    utils.exec_command(cmd)
    notify('Shuffle mode: Off', 'info', { title = string.format('Music Controls (%s)', player) })
  end
end

return M
