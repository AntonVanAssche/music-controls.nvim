local player = require('music-controls.core.player')
local feedback = require('music-controls.ui.feedback')

local M = {}

M.MPlayers = {
  desc = 'List available players',
  func = function()
    local names = player.get_all()
    if not names or #names == 0 then
      return feedback.error('No players found')
    end
    feedback.info('Available players: ' .. table.concat(names, ', '))
  end,
}

return M
