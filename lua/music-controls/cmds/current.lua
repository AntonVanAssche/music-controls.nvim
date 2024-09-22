local notify = require('notify')
local utils = require('music-controls.utils')
local M = {}

M.current = function(player)
  if not player then
    return notify('No player found', 'error', { title = 'Music Controls' })
  end

  if not utils.check_playerctl_installed() then
    return notify('Playerctl is not installed', 'error', { title = 'Music Controls' })
  end

  local cmd = string.format('playerctl -p %s metadata --format "{{ artist }} - {{ title }}"', player)
  local result = utils.exec_command(cmd)
  local state = utils.get_player_status(player)

  if result == 'No player found' then
    notify('No player found', 'warn', { title = string.format('Music Controls (%s)', player) })
  else
    notify(state .. '\n' .. result, 'info', { title = string.format('Music Controls (%s)', player) })
  end
end

return M
