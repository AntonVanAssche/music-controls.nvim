local utils = require('music-controls.utils')
local M = {}

M.list_players = function()
  if not utils.check_playerctl_installed() then
    return 'Playerctl is not installed', 'error', { title = 'Music Controls' }
  end

  local cmd = 'playerctl -l'
  local success, players = pcall(utils.exec_command, cmd)
  if not success then
    return 'Failed to fetch players', 'error', { title = 'Music Controls' }
  end

  return string.format('Players: %s', players), 'info', { title = 'Music Controls' }
end

return M
