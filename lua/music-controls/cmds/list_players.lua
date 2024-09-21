local notify = require('notify')
local utils = require('music-controls.utils')
local M = {}

M.list_players = function()
  if not utils.check_playerctl_installed() then
    return notify('Playerctl is not installed', 'error', { title = 'Music Controls' })
  end

  local cmd = 'playerctl -l'
  local players = utils.exec_command(cmd)
  notify(string.format('Players: %s', players), 'info', { title = 'Music Controls' })
end

return M
