local PlayerCore = require('music-controls.core.player')
local config = require('music-controls.config')

local M = {}

local function get_player(name)
  name = name or config.config.default_player
  local p, err = PlayerCore.new(name)
  if not p then
    return nil, err or ("Player '" .. tostring(name) .. "' not found")
  end
  return p
end

M.play = function(player_name)
  local p, err = get_player(player_name)
  if not p then
    return false, err
  end
  p.play()
  return true
end

M.pause = function(player_name)
  local p, err = get_player(player_name)
  if not p then
    return false, err
  end
  p.pause()
  return true
end

M.next = function(player_name, amount)
  local p, err = get_player(player_name)
  if not p then
    return false, err
  end
  p.next(amount or 1)
  return true
end

M.previous = function(player_name, amount)
  local p, err = get_player(player_name)
  if not p then
    return false, err
  end
  p.previous(amount or 1)
  return true
end

M.current = function(player_name)
  local p, err = get_player(player_name)
  if not p then
    return 'Stopped', 'Unknown', 'Unknown', err
  end
  local metadata = p.metadata()
  local state = p.playback_status()
  local title = metadata['xesam:title'] or 'Unknown'
  local artist = metadata['xesam:artist'] and metadata['xesam:artist'].value[1] or 'Unknown'
  return state, title, artist
end

M.shuffle = function(player_name)
  local p, err = get_player(player_name)
  if not p then
    return nil, err
  end
  local ok, current = pcall(function()
    return p.props.get('org.mpris.MediaPlayer2.Player', 'Shuffle')
  end)
  if not ok then
    return nil, 'Failed to read shuffle'
  end
  local new_state = not current
  p.props.set('org.mpris.MediaPlayer2.Player', 'Shuffle', new_state, 'b')
  return new_state
end

M.loop_set = function(player_name, mode)
  local p, err = get_player(player_name)
  if not p then
    return nil, err
  end
  p.props.set('org.mpris.MediaPlayer2.Player', 'LoopStatus', mode, 's')
  return mode
end

M.loop_toggle = function(player_name)
  local p, err = get_player(player_name)
  if not p then
    return nil, err
  end
  local ok, current = pcall(function()
    return p.props.get('org.mpris.MediaPlayer2.Player', 'LoopStatus')
  end)
  if not ok or not current then
    return nil, 'Failed to read loop status'
  end

  local modes = { 'None', 'Track', 'Playlist' }
  local index = 1
  for i, m in ipairs(modes) do
    if m == current then
      index = i
      break
    end
  end
  local new_mode = modes[(index % #modes) + 1]
  p.props.set('org.mpris.MediaPlayer2.Player', 'LoopStatus', new_mode, 's')
  return new_mode
end

return M
