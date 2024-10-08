local notify = require('notify')
local utils = require('music-controls.utils')
local M = {}

M.prev = function(player, amount)
  if not player then
    return notify('No player found', 'error', { title = 'Music Controls' })
  end

  if not utils.check_playerctl_installed() then
    return notify('Playerctl is not installed', 'error', { title = 'Music Controls' })
  end

  local cmd = string.format('playerctl -p %s  previous', player)
  for _ = 1, amount do
    utils.exec_command(cmd)
  end

  utils.sleep(0.5)
  require('music-controls.cmds.current').current(player)
end

return M