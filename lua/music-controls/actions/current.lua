local config = require('music-controls.config')
local utils = require('music-controls.utils')

local M = {}

local _get_player = function(player)
  if not player then
    return config.config.default_player
  end

  return player
end

local _get_state = function(player)
  local icons = { Playing = '▶', Paused = '⏸', Stopped = '⏹' }
  local state, err = utils.exec_command({ 'playerctl', '-p', player, 'status' })
  if err then
    return 'Unknown'
  end

  state = state and state:match('^%s*(.-)%s*$') or 'Unknown'
  return icons[state] or icons.Stopped
end

local _get_song = function(player)
  local cmd = { 'playerctl', '-p', player, 'metadata', '--format', '{{title}}\n{{artist}}' }
  local metadata, err = utils.exec_command(cmd)

  if err then
    return 'Unknown', 'Unknown'
  end

  local title = metadata and metadata:match('([^\n]+)') or 'Unknown'
  local artist = metadata and metadata:match('\n([^\n]+)') or 'Unknown'

  return title, artist
end

M.get = function(player)
  player = _get_player(player)
  local state = _get_state(player)
  local title, artist = _get_song(player)

  return state, title, artist
end

return M
