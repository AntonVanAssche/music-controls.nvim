local notify = require('notify')
local utils = require('music-controls.utils')
local M = {}

M.play = function(player)
  if not player then
    return notify('No player found', 'error', { title = 'Music Controls' })
  end

  if not utils.check_playerctl_installed() then
    return notify('Playerctl is not installed', 'error', { title = 'Music Controls' })
  end

  local cmd = string.format('playerctl -p %s play-pause', player)
  utils.exec_command(cmd)

  utils.sleep(0.25)
  require('music-controls.cmds.current').current(player)
end

return M
