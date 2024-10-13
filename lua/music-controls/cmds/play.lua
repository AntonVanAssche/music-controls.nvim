local utils = require('music-controls.utils')
local M = {}

M.play = function(player)
  if not player or player == '' then
    return 'No player found', 'error', { title = 'Music Controls' }
  end

  if not utils.check_playerctl_installed() then
    return 'Playerctl is not installed', 'error', { title = 'Music Controls' }
  end

  local cmd = string.format('playerctl -p %s play-pause', player)
  local success, _ = pcall(utils.exec_command, cmd)
  if not success then
    return 'Failed to toggle play/pause', 'error', { title = 'Music Controls' }
  end

  utils.sleep(0.25)
  return require('music-controls.cmds.current').current(player)
end

return M
