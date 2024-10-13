local utils = require('music-controls.utils')
local M = {}

M.list_players = function()
  if not utils.check_playerctl_installed() then
    return {
      state = nil,
      msg = 'Playerctl is not installed',
      lvl = 'error',
      meta = { title = 'Music Controls' },
    }
  end

  local cmd = 'playerctl -l'
  local success, players = pcall(utils.exec_command, cmd)
  if not success then
    return {
      state = nil,
      msg = 'Failed to fetch players',
      lvl = 'error',
      meta = { title = 'Music Controls' },
    }
  end

  return {
    state = nil,
    msg = string.format('Players: %s', players),
    lvl = 'info',
    meta = { title = 'Music Controls' },
  }
end

return M
