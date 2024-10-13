local utils = require('music-controls.utils')
local M = {}

M.next = function(player, amount)
  if not player or player == '' then
    return 'No player found', 'error', { title = 'Music Controls' }
  end

  if not utils.check_playerctl_installed() then
    return 'Playerctl is not installed', 'error', { title = 'Music Controls' }
  end

  amount = tonumber(amount) or 1
  local cmd = string.format('playerctl -p %s next', player)

  for _ = 1, amount do
    local success, _ = pcall(utils.exec_command, cmd)
    if not success then
      return 'Failed to skip track', 'error', { title = 'Music Controls' }
    end
  end

  utils.sleep(0.25)
  return require('music-controls.cmds.current').current(player)
end

return M
