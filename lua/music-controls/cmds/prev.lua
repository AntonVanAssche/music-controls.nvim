local utils = require('music-controls.utils')
local M = {}

M.prev = function(player, amount)
  if not player or player == '' then
    return {
      state = nil,
      msg = 'No player found',
      lvl = 'warn',
      meta = { title = 'Music Controls' },
    }
  end

  if not utils.check_playerctl_installed() then
    return {
      state = nil,
      msg = 'Playerctl is not installed',
      lvl = 'error',
      meta = { title = 'Music Controls' },
    }
  end

  amount = tonumber(amount) or 1
  local cmd = string.format('playerctl -p %s previous', player)
  for _ = 1, amount do
    local success, _ = pcall(utils.exec_command, cmd)
    if not success then
      return {
        state = nil,
        msg = 'Failed to skip to the previous track',
        lvl = 'error',
        meta = { title = 'Music Controls' },
      }
    end
  end

  utils.sleep(0.5)
  return require('music-controls.cmds.current').current(player)
end

return M
