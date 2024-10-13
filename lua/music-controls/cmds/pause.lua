local utils = require('music-controls.utils')
local M = {}

M.pause = function(player)
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

  local cmd = string.format('playerctl -p %s pause', player)
  local success, _ = pcall(utils.exec_command, cmd)
  if not success then
    return {
      state = nil,
      msg = 'Failed to pause the player',
      lvl = 'error',
      meta = { title = 'Music Controls' },
    }
  end

  utils.sleep(0.25)
  return require('music-controls.cmds.current').current(player)
end

return M
