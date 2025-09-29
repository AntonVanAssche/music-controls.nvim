local controls = require('music-controls.core.controls')
local config = require('music-controls.config').config

local M = {}

M.display = function()
  local state, title, artist = controls.current(config.default_player)
  local state_icons = { Playing = '♫', Paused = '⏸', Stopped = '⏹' }

  return string.format(
    '%s %s - %s',
    state_icons[state and state:match('%S+') or 'Unknown'] or '?',
    title or 'No Track',
    artist or 'Unknown Artist'
  )
end

return M
