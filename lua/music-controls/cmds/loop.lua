local notify = require('notify')
local utils = require('music-controls.utils')
local M = {}

local function loop_state(player)
  local cmd = string.format('playerctl -p %s loop', player)
  return utils.exec_command(cmd)
end

M.loop = function(player, mode)
  if not player then
    return notify('No player found', 'error', { title = 'Music Controls' })
  end

  if not utils.check_playerctl_installed() then
    return notify('Playerctl is not installed', 'error', { title = 'Music Controls' })
  end

  local _mode = mode or 'Track'
  local cmd = string.format('playerctl -p %s loop %s', player, _mode)
  utils.exec_command(cmd)

  utils.sleep(0.25)
  local state = loop_state(player)
  notify(string.format('Loop mode: %s', state), 'info', { title = string.format('Music Controls (%s)', player) })
end

M.loop_toggle = function(player)
  if not player then
    return notify('No player found', 'error', { title = 'Music Controls' })
  end

  if not utils.check_playerctl_installed() then
    return notify('Playerctl is not installed', 'error', { title = 'Music Controls' })
  end

  local state = loop_state(player)
  if state == 'None' then
    M.loop(player, 'Track')
  else
    M.loop(player, 'None')
  end
end

return M
